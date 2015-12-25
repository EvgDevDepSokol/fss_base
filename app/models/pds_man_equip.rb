class PdsManEquip < ActiveRecord::Base

  self.table_name = 'pds_man_equip'

  alias_attribute :type, :Type

  def custom_hash
    serializable_hash
  end

  def serializable_hash(options={})
    super options.merge(methods: :id)
  end

end
