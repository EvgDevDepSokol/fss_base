class Tablelist < ActiveRecord::Base
  self.table_name = 'tablelist'
  alias_attribute :id, self.primary_key
  def custom_hash
    serializable_hash.merge(id: id)
  end
end
