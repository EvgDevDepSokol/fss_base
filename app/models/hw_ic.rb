# frozen_string_literal: true

# I&C table
class HwIc < ApplicationRecord
  self.table_name = 'hw_ic'
  include DbmGeneratorHelper
  include EquipmentPanelsHelper
  attr_accessor :skip_callbacks
  alias_attribute :id, primary_key

  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist', inverse_of: :hw_ics
  belongs_to :hw_ped, foreign_key: :ped, class_name: 'HwPed', inverse_of: :hw_ics
  belongs_to :pds_project_unit, foreign_key: :Unit, class_name: 'PdsProjectUnit', inverse_of: :hw_ics
  belongs_to :pds_panel, foreign_key: :panel_id, inverse_of: :hw_ics
  belongs_to :pds_project, foreign_key: 'Project', inverse_of: :hw_ics
  has_many :pds_buttons, dependent: :restrict_with_error, foreign_key: 'IC', inverse_of: :hw_ic

  alias_attribute :system_id, :sys
  alias_attribute :hw_ped_id, :ped
  alias_attribute :pds_project_unit_id, :Unit
  alias_attribute :pds_panel_id, :panel_id

  validate :duplicate_exists, on: :create

  def self.plucked
    true
  end

  def custom_hash
    serializable_hash(include: {
                        system: { only: :System },
                        pds_panel: { only: [:panel] },
                        pds_project_unit: { only: [], include: { unit: { only: :Unit_RU } } },
                        hw_ped: { only: :ped, include: { hw_devtype: { only: [:RuName] } } }
                      })
  end

  def duplicate_exists
    errors.add(:hw_ic, ' Запись с таким "REF" в этом проекте уже существует.') if HwIc.where(ref: ref, Project: self.Project).count > 0
  end

  after_save do |hw_ic|
    next if hw_ic.skip_callbacks

    if hw_ic.ped_before_last_save.nil?
      add_equipment
    elsif hw_ic.ped_before_last_save && (table_by_ped(hw_ic.ped) != table_by_ped(hw_ic.ped_before_last_save))
      destroy_equipment
      add_equipment
    else
      tbl_name = table_by_ped(hw_ic.ped)
      if tbl_name != 'pds_mnemo' && (hw_ic.sys_before_last_save != hw_ic.sys)
        obj = Object.const_get(tbl_name.classify).where(IC: hw_ic.icID, Project: hw_ic.Project).first
        obj.sys = hw_ic.sys
        obj.save
      end
    end
  end

  after_destroy do |hw_ic|
    next if hw_ic.skip_callbacks

    destroy_equipment
  end

  def table_by_ped(ped)
    Tablelist.find(HwDevtype.find(HwPed.find(ped).type).typetable).table
  end

  def add_equipment
    tbl_name = table_by_ped(ped)
    unless tbl_name == 'pds_mnemo'
      obj = Object.const_get(tbl_name.classify).new
      obj.IC = icID
      obj.Project = self.Project
      obj.sys = sys
      obj.save
    end
  end

  def destroy_equipment
    tbl_name = table_by_ped(ped)
    unless tbl_name == 'pds_mnemo'
      tbl = Object.const_get(tbl_name.classify)
      obj = tbl.where(IC: icID).to_a
      obj.each(&:destroy)
    end
  end
end
