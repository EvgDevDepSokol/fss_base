class PdsSysDescription < ActiveRecord::Base

  self.table_name = 'pds_sys_description'

  belongs_to :pds_project, foreign_key: 'Project'
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'

  def custom_hash
    serializable_hash(include: {
        system: {only: [:System]}})
  end

end
