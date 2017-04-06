class Role < ApplicationRecord
  self.table_name = 'roles'
  self.primary_key = 'roleID'
  alias_attribute :id, primary_key

  def custom_hash
    serializable_hash
  end
end
