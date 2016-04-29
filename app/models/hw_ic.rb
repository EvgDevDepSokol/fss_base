class HwIc < ActiveRecord::Base
  # belongs_to :panel

  self.table_name = 'hw_ic'

  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :hw_ped, foreign_key: :pedID, class_name: 'HwPed'
  belongs_to :pds_project_unit, foreign_key: :Unit, class_name: 'PdsProjectUnit'
  belongs_to :pds_panel, foreign_key: :panel
  # delegate :unit, to: :pds_project_unit

  alias_attribute :system_id, :sys
  alias_attribute :hw_ped_id, :pedID
  alias_attribute :pds_project_unit_id, :Unit
  alias_attribute :pds_panel_id, :panel

  validates_length_of :ref, maximum: 128
  validates_length_of :rev, maximum: 1
  validates_length_of :tag_no, maximum: 330

  def custom_map
    true
  end

  def custom_hash
    serializable_hash(include: {
                        system: { only: :System },
                        pds_panel: { only: [:panel] },
                        pds_project_unit: { only: [], include: { unit: { only: :Unit_RU } } },
                        hw_ped: { only: :ped, include: { hw_devtype: { only: [:RuName] } } } })
  end

  def serializable_hash(options = {})
    super options.merge(methods: :id)
  end
end
