class Contract < ApplicationRecord
  self.table_name = 'contract'
  alias_attribute :id, primary_key
end
