# frozen_string_literal: true

# Project. Contains copy/destroy all project objets procedures
class PdsProject < ApplicationRecord
  self.table_name = 'pds_project'
  include EquipmentPanelsHelper
  alias_attribute :id, primary_key
  belongs_to :company, foreign_key: :companyID
  has_one :project_properties, foreign_key: :ProjectID, class_name: 'PdsProjectProperty'

  has_many :hw_ic, dependent: :restrict_with_error, foreign_key: 'Project'

  def name
    project_name
  end

  def custom_hash
    serializable_hash.merge(id: id)
  end

  public

  def duplicate_project
    tbls = Tablelist.where.not(table: nil).order(:table).pluck(:table).to_a
    project_old_id = 83
    project_new_id = 80_000_002
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
          tbl_class.where(Project: project_new_id).delete_all
        rescue StandardError
          repeat = true
        end
      end
    end while repeat == true
    # copy objects from old to new project
    tbls_with_prj.each do |tbl_name|
      tbl_class = tbl_name.constantize
      tbl_hash = {}
      scope_old = tbl_class.where(Project: project_old_id).to_a
      scope_old.each do |obj|
        obj_new = obj.dup
        obj_new.skip_callbacks = true if tbls_with_callbacks.include?(tbl_name)
        obj_new.Project = project_new_id
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
      scope_new = tbl_class.where(Project: project_new_id).to_a
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
      num_old = tbl_class.where(Project: project_old_id).count
      num_new = tbl_class.where(Project: project_new_id).count
      printf '%s: было %i, стало %i', tbl_name, num_old, num_new if num_new != num_old
    end
  end
end
