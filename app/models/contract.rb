class Contract < ActiveRecord::Base
  self.table_name = 'contract'
  alias_attribute :id, self.primary_key
end
