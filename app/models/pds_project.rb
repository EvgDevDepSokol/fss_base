class PdsProject < ActiveRecord::Base
  self.table_name = 'pds_project'
  belongs_to :company, foreign_key: :companyID
  has_one :project_properties, foreign_key: :ProjectID, class_name: 'PdsProjectProperty'

  def name
    project_name
  end

  def custom_hash
    serializable_hash.merge({id: id})
  end

end
