class PdsMetersChannel < ActiveRecord::Base
  belongs_to :hw_ic, foreign_key: 'IC'
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_project, foreign_key: 'Project'
  belongs_to :pds_section_assembler, foreign_key: 'ctrl_power'

  alias_attribute :hw_ic_id, :IC
  alias_attribute :system_id, :sys
  alias_attribute :pds_section_assembler_id, :ctrl_power

  schema_validations

  def custom_hash
    serializable_hash(include: {
                        hw_ic: { only: [:ref, :tag_no, :Description, :scaleMin, :scaleMax],
                                 include: {
                                   hw_ped: { only: [:ped] },
                                   pds_project_unit: { include: {
                                     unit: { only: :Unit_RU }
                                   },
                                                       only: [] }
                                 } },
                        system: { only: [:System] },
                        pds_section_assembler: { only: [:section_name] }
                      })
  end
end
