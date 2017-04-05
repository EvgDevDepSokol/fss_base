class HwIosignal < ActiveRecord::Base
  self.table_name = 'hw_iosignal'
  alias_attribute :id, primary_key

  belongs_to :hw_ped, foreign_key: :pedID, class_name: 'HwPed'
  belongs_to :hw_iosignaldef, foreign_key: :signID, class_name: 'HwIosignaldef'
  alias_attribute :hw_ped_id, :pedID
  alias_attribute :hw_iosignaldef_id, :signID

  def custom_hash
    serializable_hash(include: {
                        hw_ped: { only: [:ped] },
                        hw_iosignaldef: { only: [:ioname] }
                      })
  end
end
