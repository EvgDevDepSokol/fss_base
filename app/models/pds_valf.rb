# frozen_string_literal: true

class PdsValf < ApplicationRecord
  self.inheritance_column = :_type_disabled
  alias_attribute :id, primary_key
  TYPES = ['valve', 'vlv_cntr', 'vlv_relief', 'vlv_pneumo', 'vlv_sol', 'vlv_check', 'vlv_hydr', 'R/C', nil].freeze
  DEPARTMENT_TYPES = ['Турбинное', 'Реакторное', nil].freeze
  belongs_to :pds_project, foreign_key: 'Project'

  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :psa_ctrl_power, foreign_key: 'ctrl_power', primary_key: 'section_N', class_name: 'PdsSectionAssembler'
  belongs_to :psa_ed_power, foreign_key: 'ed_power', primary_key: 'section_N', class_name: 'PdsSectionAssembler'
  belongs_to :psa_anc_power, foreign_key: 'anc_power', primary_key: 'section_N', class_name: 'PdsSectionAssembler'
  belongs_to :pds_man_equip, foreign_key: 'eq_type'
  belongs_to :pds_documentation, foreign_key: 'doc_reg_N'
  belongs_to :sd_sys_numb, foreign_key: 'sd_N', inverse_of: :pds_valves

  alias_attribute :system_id, :sys
  alias_attribute :psa_ctrl_power_id, :ctrl_power
  alias_attribute :psa_ed_power_id, :ed_power
  alias_attribute :psa_anc_power_id, :anc_power
  alias_attribute :pds_man_equip_id, :eq_type
  alias_attribute :pds_documentation_id, :doc_reg_N
  alias_attribute :sd_sys_numb_id, :sd_N

  # has_many :pds_regulators, dependent: :restrict_with_error, foreign_key: 'vlv_1'
  # has_many :pds_regulators, dependent: :restrict_with_error, foreign_key: 'vlv_2'

  validates :Type, inclusion: TYPES, if: :present?
  validates :Department, inclusion: DEPARTMENT_TYPES, if: :present?

  def self.plucked
    true
  end

  def custom_hash
    serializable_hash(include: {
                        system: { only: :System },
                        psa_ctrl_power: { only: :section_name },
                        psa_ed_power: { only: :section_name },
                        psa_anc_power: { only: :section_name },
                        pds_man_equip: { only: :Type },
                        pds_documentation: { only: :DocTitle },
                        sd_sys_numb: { only: [:sd_link] }
                      })
  end
end
