class HwIc < ApplicationRecord
  self.table_name = 'hw_ic'
  include DbmGeneratorHelper
  alias_attribute :id, primary_key

  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :hw_ped, foreign_key: :ped, class_name: 'HwPed'
  belongs_to :pds_project_unit, foreign_key: :Unit, class_name: 'PdsProjectUnit'
  belongs_to :pds_panel, foreign_key: :panel_id
  belongs_to :pds_project, foreign_key: 'Project'
  # delegate :unit, to: :pds_project_unit

  alias_attribute :system_id, :sys
  alias_attribute :hw_ped_id, :ped
  alias_attribute :pds_project_unit_id, :Unit
  alias_attribute :pds_panel_id, :panel_id

  # validates_length_of :ref, maximum: 128
  # validates_length_of :rev, maximum: 1
  # validates_length_of :tag_no, maximum: 330
  # validates_presence_of :ref, :ped

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
    if HwIc.where(ref: ref, Project: self.Project).count > 0
      errors.add(:hw_ic, ' Запись с таким "REF" в этом проекте уже существует.')
    end
  end

  after_save do |hw_ic|
    byebug
    if hw_ic.ped_before_last_save.nil?
      add_equipment(hw_ic)
    elsif hw_ic.ped_before_last_save && (table_by_ped(hw_ic.ped) != table_by_ped(hw_ic.ped_before_last_save))
      destroy_equipment(hw_ic)
      add_equipment(hw_ic)
    else
      tbl_name = table_by_ped(hw_ic.ped)
      if  tbl_name != 'pds_mnemo' && (hw_ic.sys_before_last_save != hw_ic.sys)
        e = Object.const_get(tbl_name.classify).where(IC: hw_ic.icID, Project: hw_ic.Project).first
        e.sys = hw_ic.sys
        e.save
      end
    end
  end

  after_destroy do |hw_ic|
    destroy_equipment(hw_ic)
  end

  def table_by_ped(ped)
    Tablelist.find(HwDevtype.find(HwPed.find(ped).type).typetable).table
  end

  def add_equipment(hw_ic)
    tbl_name = table_by_ped(hw_ic.ped)
    if tbl_name == 'pds_mnemo'
      # e.Code = hw_ic.ref
    elsif
      e = Object.const_get(tbl_name.classify).new
      e.IC = hw_ic.icID
      e.Project = hw_ic.Project
      e.sys = hw_ic.sys
      e.save
    end
  end

  def destroy_equipment(hw_ic)
    tbl_name = table_by_ped(hw_ic.ped)
    if tbl_name == 'pds_mnemo'
      # e = tbl.where(Code: hw_ic.ref).to_a
    elsif
      tbl = Object.const_get(tbl_name.classify)
      e = tbl.where(IC: hw_ic.icID).to_a
      e.each(&:destroy)
    end
  end
end
