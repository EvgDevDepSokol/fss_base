class PdsDetector < ActiveRecord::Base
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_project, foreign_key: 'Project'
  belongs_to :pds_section_assembler, foreign_key: 'ctrl_power'
  belongs_to :pds_man_equip, foreign_key: 'eq_type'
  belongs_to :pds_documentation, foreign_key: 'doc_reg_N'
  belongs_to :pds_project_unit, foreign_key: 'Unit'
  belongs_to :sd_sys_numb, foreign_key: 'sd_N'

  alias_attribute :system_id, :sys
  alias_attribute :pds_section_assembler_id, :ctrl_power
  alias_attribute :pds_man_equip_id, :eq_type
  alias_attribute :pds_documentation_id, :doc_reg_N
  alias_attribute :pds_project_unit_id, :Unit
  alias_attribute :sd_sys_numb_id, :sd_N

  schema_validations

  def custom_map
    true
  end

  def custom_hash
    serializable_hash(include: {
                        system: { only: :System },
                        pds_section_assembler: { only: :section_name },
                        pds_project_unit: { only: [], include: { unit: { only: :Unit_RU } } },
                        pds_man_equip: { only: :Type },
                        sd_sys_numb: { only: [:sd_link] }
                      })
  end

  #  def serializable_hash(options={})
  #    super options.merge(methods: :id)
  #  end
end
