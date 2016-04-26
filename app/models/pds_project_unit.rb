class PdsProjectUnit < ActiveRecord::Base
  self.table_name = 'pds_project_unit'
  belongs_to :pds_project, foreign_key: 'Project'
  belongs_to :unit, foreign_key: 'Unit', class_name: 'PdsUnit'

  def custom_hash
    serializable_hash(include:
        { unit: { only: [:Unit_RU, :Unit_EN] } })
  end
end
