class PdsEquip < ActiveRecord::Base
  self.primary_key = 'TEquipID'
  alias_attribute :id, self.primary_key

  validate :test

  def test
    false
  end

  def custom_hash
    serializable_hash.merge(id: id)
  end
end
