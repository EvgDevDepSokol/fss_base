class PdsEquip < ApplicationRecord
  self.primary_key = 'TEquipID'
  alias_attribute :id, primary_key

  validate :test

  def test
    false
  end

  def custom_hash
    serializable_hash.merge(id: id)
  end
end
