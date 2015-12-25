class PdsDetector < ActiveRecord::Base

  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_project, foreign_key: 'Project'
  belongs_to :pds_section_assembler, foreign_key: 'ctrl_power'
  belongs_to :pds_man_equip, foreign_key: 'eq_type'
  belongs_to :pds_sd, foreign_key: 'sd_N'
  belongs_to :pds_documentation, foreign_key: 'doc_reg_N'
  belongs_to :pds_project_unit, foreign_key: :Unit, class_name: 'PdsProjectUnit'

  alias_attribute :system_id, :sys
  alias_attribute :pds_section_assembler_id, :ctrl_power
  alias_attribute :pds_man_equip_id, :eq_type
  alias_attribute :pds_sd_id, :sd_N
  alias_attribute :pds_documentation_id, :doc_reg_N
  alias_attribute :pds_project_unit_id, :Unit

  schema_validations

  def custom_hash
    serializable_hash(include: {
        system: {only: :System},
        pds_section_assembler: {only: :section_name},
        pds_project_unit: {only: [], include: {unit: {only: :Unit_RU}}},
        pds_man_equip: {only: :Type},
        pds_sd: {only: :SdTitle},
        pds_documentation: {only: :DocTitle}
    })
  end

end
