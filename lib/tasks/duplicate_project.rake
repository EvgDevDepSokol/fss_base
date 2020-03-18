# frozen_string_literal: true

require 'rake'

namespace :duplicate_project do
  desc 'Create New Project'
  task :create_new, %i[project_n_id] => [:environment] do |_task, args|
    project_n_id = args[:project_n_id]
    if PdsProject.where(id: project_n_id).count < 1
      project_n = PdsProject.new
      project_n.ProjectID = project_n_id
      project_n.project_name = project_n_id.to_s
      project_n.project_number = project_n_id.to_s
      project_n.Contractor = 'ВНИИАЭС'
      project_n.save
    else
      puts 'Project with such id is present in DB already'
    end
  end

  desc 'Copy all data from old project to the new one, lall=false->copy only projectSettingsActions'
  task :copy_all, %i[project_o_id project_n_id lall=true] => [:environment] do |_task, args|
    project_n_id = args[:project_n_id]
    project_o_id = args[:project_o_id]
    lall = args[:lall]
    tbls = if lall
             Tablelist.where.not(table: nil).order(:table).pluck(:table).to_a
           else
             # ProjectSettingsController::ACTIONS
             %w[pds_eng_on_sys pds_project_unit pds_project_sys pds_simplifications pds_sys_description]
           end
    tbls_with_prj = []
    old2new = {}
    # create list of tables with 'project' attribute
    tbls_with_callbacks = %w[HwIc PdsMalfunction]
    skip_tables = %w[news pds_algo_input]
    tbls.each do |tbl_name|
      next if skip_tables.include?(tbl_name)

      tbl_class = tbl_name.classify.constantize
      next unless tbl_class.column_names.include? 'Project'

      tbls_with_prj.push(tbl_name.classify)
    end
    # clean new project items
    begin
      repeat = false
      tbls_with_prj.each do |tbl_name|
        tbl_class = tbl_name.constantize
        begin
          tbl_class.where(Project: project_n_id).delete_all
        rescue StandardError
          repeat = true
        end
      end
    end while repeat == true
    # copy objects from old to new project
    tbls_with_prj.each do |tbl_name|
      tbl_class = tbl_name.constantize
      tbl_hash = {}
      scope_old = tbl_class.where(Project: project_o_id).to_a
      scope_old.each do |obj|
        obj_new = obj.dup
        obj_new.skip_callbacks = true if tbls_with_callbacks.include?(tbl_name)
        obj_new.Project = project_n_id
        obj_new.save
        tbl_hash[obj.id] = obj_new.id
      end
      old2new[tbl_name] = tbl_hash
    end
    # modify external keys
    tbls_with_prj.each do |tbl_name|
      tbl_class = tbl_name.constantize
      ext_keys = []
      tbl_class.reflections.each do |_key, refl|
        next unless refl.macro == :belongs_to

        tbl_link_name = (refl.options[:class_name] || refl.name.to_s).classify
        ext_keys.push(tbl: tbl_link_name, key: refl.foreign_key) if tbls_with_prj.include?(tbl_link_name)
      end
      scope_new = tbl_class.where(Project: project_n_id).to_a
      scope_new.each do |obj|
        ext_keys.each do |ekey|
          obj[ekey[:key]] = old2new[ekey[:tbl]][obj[ekey[:key]]] if old2new[ekey[:tbl]][obj[ekey[:key]]]
        end
        if obj.changed?
          obj.skip_callbacks = true if tbls_with_callbacks.include?(tbl_name)
          obj.save
        end
      end
    end
    # check if tables have the same amount of objects
    tbls_with_prj.each do |tbl_name|
      tbl_class = tbl_name.constantize
      num_old = tbl_class.where(Project: project_o_id).count
      num_new = tbl_class.where(Project: project_n_id).count
      printf '%s: было %i, стало %i', tbl_name, num_old, num_new if num_new != num_old
    end
  end

  desc 'Delete old project'
  task :delete_old, %i[project_o_id] => [:environment] do |_task, args|
    project_o_id = args[:project_o_id]
    tbls = Tablelist.where.not(table: nil).order(:table).pluck(:table).to_a
    tbls_with_prj = []
    # create list of tables with 'project' attribute
    skip_tables = %w[news pds_algo_input]
    tbls.each do |tbl_name|
      next if skip_tables.include?(tbl_name)

      tbl_class = tbl_name.classify.constantize
      next unless tbl_class.column_names.include? 'Project'

      tbls_with_prj.push(tbl_name.classify)
    end
    # clean old project items
    begin
      repeat = false
      tbls_with_prj.each do |tbl_name|
        tbl_class = tbl_name.constantize
        begin
          tbl_class.where(Project: project_o_id).delete_all
        rescue StandardError
          puts tbl_class
          repeat = true
        end
      end
    end while repeat == true
  end
end
