# frozen_string_literal: true

class PdsAnnounciator < ApplicationRecord
  include EquipmentPanelsHelper
  self.table_name = 'pds_announciator'
  alias_attribute :id, primary_key
  # self.inheritance_column = nil
  self.inheritance_column = 'inheritance_type'
  schema_validations except: :hw_ic

  belongs_to :hw_ic, foreign_key: 'IC'
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_project, foreign_key: 'Project'
  belongs_to :pds_section_assembler, foreign_key: 'ctrl_power'
  belongs_to :pds_detector, foreign_key: 'Detector'

  alias_attribute :hw_ic_id, :IC
  alias_attribute :system_id, :sys
  alias_attribute :pds_section_assembler_id, :ctrl_power
  alias_attribute :pds_detector_id, :Detector

  validates :Type, inclusion: %w[AN YC], allow_blank: true
  validates :sign, inclusion: %w[предупр. авар.], allow_blank: true

  def self.plucked
    true
  end

  def custom_hash
    serializable_hash(include: {
                        hw_ic: { only: %i[ref tag_no Description], include: { hw_ped: { only: [:ped] } } },
                        system: { only: [:System] },
                        pds_section_assembler: { only: [:section_name] },
                        pds_detector: { only: [:tag] }
                      })
  end

  after_save do |element|
    set_sys_to_hw_ic(element)
  end
end
