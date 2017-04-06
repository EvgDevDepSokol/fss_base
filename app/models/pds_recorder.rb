class PdsRecorder < ApplicationRecord
  self.table_name = 'pds_recorders'
  alias_attribute :id, primary_key
  schema_validations except: :hw_ic

  belongs_to :hw_ic, foreign_key: 'IC'
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_project, foreign_key: 'Project'
  belongs_to :pds_section_assembler, foreign_key: 'ctrl_power'

  alias_attribute :hw_ic_id, :IC
  alias_attribute :system_id, :sys
  alias_attribute :pds_section_assembler_id, :ctrl_power

  def custom_hash
    serializable_hash(include: {
                        hw_ic: { only: %i[ref tag_no Description], include: { hw_ped: { only: [:ped] } } },
                        system: { only: [:System] },
                        pds_section_assembler: { only: [:section_name] }
                      })
  end
end
