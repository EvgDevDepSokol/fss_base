# frozen_string_literal: true

class PdsMetersDigital < ApplicationRecord
  include EquipmentPanelsHelper
  self.table_name = 'pds_meters_digital'
  alias_attribute :id, primary_key
  schema_validations except: :hw_ic

  belongs_to :hw_ic, foreign_key: 'IC'
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_project, foreign_key: 'Project'
  belongs_to :pds_section_assembler, foreign_key: 'ctrl_power'

  alias_attribute :hw_ic_id, :IC
  alias_attribute :system_id, :sys
  alias_attribute :pds_section_assembler_id, :ctrl_power

  def self.plucked
    true
  end

  def custom_hash
    serializable_hash(include: {
                        hw_ic: { only: %i[ref tag_no Description scaleMin scaleMax],
                                 include: {
                                   hw_ped: { only: [:ped] },
                                   pds_project_unit: { only: [], include: { unit: { only: :Unit_RU } } }
                                 } },
                        system: { only: [:System] },
                        pds_section_assembler: { only: [:section_name] }
                      })
  end

  after_save do |element|
    set_sys_to_hw_ic(element)
  end
end
