class PdsSwitchNofix < ActiveRecord::Base
  self.table_name = 'pds_switch_nofix'
  schema_validations except: :hw_ic

  belongs_to :hw_ic, foreign_key: 'IC'
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_project, foreign_key: 'Project'
  # delegate :hw_ped, to: :hw_ic

  alias_attribute :hw_ic_id, :IC
  alias_attribute :system_id, :sys

  def custom_map
    true
  end

  def custom_hash
    serializable_hash(include: {
                        hw_ic: { only: [:ref, :tag_no, :Description], include: { hw_ped: { only: [:ped] } } },
                        system: { only: [:System] }
                      })
  end
end
