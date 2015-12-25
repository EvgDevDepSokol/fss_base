class HwPed < ActiveRecord::Base

  self.inheritance_column = nil

  belongs_to :hw_devtype, foreign_key: :type

  alias_attribute :hw_devtype_id, :type


  def to_s
    self.ped
  end

  def custom_hash
    serializable_hash(include: {hw_devtype: {only: [:RuName]}})end

  def serializable_hash(options={})
    super options.merge(methods: :id)
  end

end
