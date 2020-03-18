# frozen_string_literal: true

class PdsDetector < ApplicationRecord
  # include FastJsonapi::ObjectSerializer
  alias_attribute :id, primary_key
  attribute :pds_syslist, &:system
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist', inverse_of: :pds_detectors
  belongs_to :pds_project, foreign_key: 'Project', inverse_of: :pds_detectors
  belongs_to :pds_section_assembler, foreign_key: 'ctrl_power', inverse_of: :pds_detectors
  belongs_to :pds_man_equip, foreign_key: 'eq_type', inverse_of: :pds_detectors
  belongs_to :pds_documentation, foreign_key: 'doc_reg_N', inverse_of: :pds_detectors
  belongs_to :pds_project_unit, foreign_key: 'Unit', inverse_of: :pds_detectors
  belongs_to :sd_sys_numb, foreign_key: 'sd_N', inverse_of: :pds_detectors

  alias_attribute :system_id, :sys
  alias_attribute :pds_section_assembler_id, :ctrl_power
  alias_attribute :pds_man_equip_id, :eq_type
  alias_attribute :pds_documentation_id, :doc_reg_N
  alias_attribute :pds_project_unit_id, :Unit
  alias_attribute :sd_sys_numb_id, :sd_N

  has_many :pds_mnemo, dependent: :restrict_with_error, foreign_key: 'Detector'
  has_many :pds_ppca, dependent: :restrict_with_error, foreign_key: 'Detector'
  has_many :pds_ppcd, dependent: :restrict_with_error, foreign_key: 'Detector'
  has_many :pds_regulators, dependent: :restrict_with_error, foreign_key: 'det_id'

  def self.plucked
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
end
