class PdsAlarm < ApplicationRecord
  self.table_name = 'pds_alarm'
  alias_attribute :id, primary_key
  schema_validations except: :hw_ic

  belongs_to :hw_ic, foreign_key: 'IC'
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_project, foreign_key: 'Project'

  alias_attribute :hw_ic_id, :IC
  alias_attribute :system_id, :sys

  def custom_hash
    serializable_hash(include: {
                        hw_ic: { only: %i[ref tag_no Description], include: { hw_ped: { only: [:ped] } } },
                        system: { only: [:System] }
                      })
  end
end
