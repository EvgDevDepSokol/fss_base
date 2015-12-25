class PdsEquip < ActiveRecord::Base

  self.primary_key = 'TEquipID'

  validate :test

  def test
    false
  end

end
