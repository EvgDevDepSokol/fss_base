class Audit < ActiveRecord::Base
  self.table_name = 'audit'
  alias_attribute :id, self.primary_key
  def custom_hash
    serializable_hash.merge(id: id)
  end
end
