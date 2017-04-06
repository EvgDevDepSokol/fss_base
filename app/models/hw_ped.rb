class HwPed < ApplicationRecord
  self.inheritance_column = nil
  self.table_name = 'hw_peds'
  alias_attribute :id, primary_key

  belongs_to :hw_devtype, foreign_key: :type

  has_many :hw_ic, dependent: :restrict_with_error, foreign_key: 'pedID'
  has_many :hw_iosignal, dependent: :restrict_with_error, foreign_key: 'pedID'
  has_many :hw_wirelist, dependent: :restrict_with_error, foreign_key: 'pedID'

  alias_attribute :hw_devtype_id, :type

  #  def to_s
  #    ped
  #  end

  def custom_hash
    serializable_hash(include: { hw_devtype: { only: [:RuName] } })
  end
end
