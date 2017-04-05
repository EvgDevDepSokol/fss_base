class HwWirelist < ActiveRecord::Base
  self.table_name = 'hw_wirelist'
  alias_attribute :id, primary_key
  belongs_to :pds_panel, foreign_key: :panel
  belongs_to :hw_ped, foreign_key: :pedID, class_name: 'HwPed'
  belongs_to :pds_project_unit, foreign_key: :Unit, class_name: 'PdsProjectUnit'
  belongs_to :hw_ic, foreign_key: :IC

  alias_attribute :hw_ped_id, :pedID
  alias_attribute :pds_project_unit_id, :Unit
  alias_attribute :pds_panel_id, :panel
  alias_attribute :hw_ic_id, :IC

  def custom_map
    true
  end

  # TODO: pds_panel link not working
  def custom_hash
    serializable_hash(include: {
                        pds_panel: { only: [:panel] },
                        hw_ic: { only: [:ref] },
                        hw_ped: { only: [:ped] }
                      })
  end
end
