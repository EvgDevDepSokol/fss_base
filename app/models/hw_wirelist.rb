class HwWirelist < ActiveRecord::Base
  self.table_name = 'hw_wirelist'
  belongs_to :pds_panel, foreign_key: :panel
  belongs_to :hw_ped, foreign_key: :ped, class_name: 'HwPed'
  belongs_to :pds_project_unit, foreign_key: :Unit, class_name: 'PdsProjectUnit'

  alias_attribute :hw_ped_id, :ped
  alias_attribute :pds_project_unit_id, :Unit
  alias_attribute :pds_panel_id, :panel

  def custom_map
    true
  end

  # TODO: pds_panel link not working
  def custom_hash
    serializable_hash(include: {
                        pds_panel: { only: [:panel] },
                        hw_ped: { only: [:ped],
                                  include: { hw_devtype: { only: [:RuName] } } } })
  end

  #  def serializable_hash(options={})
  #    super options.merge(methods: :id)
  #  end
end
