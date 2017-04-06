class Audit < ApplicationRecord
  self.table_name = 'audit'
  alias_attribute :id, primary_key
  def custom_hash
    serializable_hash.merge(id: id)
  end
end
