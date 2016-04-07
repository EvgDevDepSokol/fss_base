class PdsManEquip < ActiveRecord::Base

  self.table_name = 'pds_man_equip'

  alias_attribute :type, :Type
  alias_attribute :id, :EquipN

  def custom_hash
    serializable_hash(methods: [:id, :Type, :Descriptor, :Comp_malf])
  end

  def serializable_hash(options={})
    super options.merge(methods: :id)
  end

end
