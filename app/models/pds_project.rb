class PdsProject < ApplicationRecord
  self.table_name = 'pds_project'
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
    tables = Tablelist.where.not(table: nil).pluck(:table).to_a
    project_old_id = 83
    project_new_id = 80_000_002
    byebug
    tables_with_prj = []
    tables.each do |tbl_name|
      tbl_class = tbl_name.classify.constantize
      next unless tbl_class.column_names.include? 'Project'

      tables_with_prj.push(tbl_name)
      # clean new project items
      tbl_class.where(Project: project_new_id).to_a.each(&:destroy)
      scope_old = tbl_class.where(Project: project_old_id).to_a
      scope_old.each do |obj|
        obj_new = obj.dup
        obj_new.Project = project_new_id
        obj_new.save
        old2new[tbl_name][obj.id] = obj_new.id
      end
    end
  end
end
