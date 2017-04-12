class HwIc < ApplicationRecord
  self.table_name = 'hw_ic'
  alias_attribute :id, primary_key

  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :hw_ped, foreign_key: :pedID, class_name: 'HwPed'
  belongs_to :pds_project_unit, foreign_key: :Unit, class_name: 'PdsProjectUnit'
  belongs_to :pds_panel, foreign_key: :panel_id
  # delegate :unit, to: :pds_project_unit

  alias_attribute :system_id, :sys
  alias_attribute :hw_ped_id, :pedID
  alias_attribute :pds_project_unit_id, :Unit
  alias_attribute :pds_panel_id, :panel_id

  # validates_length_of :ref, maximum: 128
  # validates_length_of :rev, maximum: 1
  # validates_length_of :tag_no, maximum: 330
  # validates_presence_of :ref, :pedID

  validate :duplicate_exists, on: :create

  def plucked
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
    if hw_ic.pedID_was.nil?
      add_equipment(hw_ic)
    elsif hw_ic.pedID_was && (hw_ic.pedID != hw_ic.pedID_was)
      destroy_equipment(hw_ic)
      add_equipment(hw_ic)
    end
  end

  after_destroy do |hw_ic|
    destroy_equipment(hw_ic)
  end

  def table_by_pedid(pedID)
    Tablelist.find(HwDevtype.find(HwPed.find(pedID).type).typetable).table
  end

  def add_equipment(hw_ic)
    e = Object.const_get(table_by_pedid(hw_ic.pedID).classify).new
    e.IC = hw_ic.icID
    e.Project = hw_ic.Project
    e.save
  end

  def destroy_equipment(hw_ic)
    tbl = Object.const_get(table_by_pedid(hw_ic.pedID_was).classify)
    e_was = tbl.where(IC: hw_ic.icID).to_a
    e_was.each(&:destroy)
  end
end
