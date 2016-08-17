class PdsProjectSy < ActiveRecord::Base
  self.table_name = 'pds_project_sys'
  belongs_to :pds_project, foreign_key: 'Project'
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  alias_attribute :system_id, :sys

  def custom_hash
    serializable_hash(include: {
                        system: { only: [:System] }
                      })
  end
end
