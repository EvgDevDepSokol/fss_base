class HwIcSys < ActiveRecord::Base
  self.table_name = 'hw_ic_sys'
  alias_attribute :id, self.primary_key
end
