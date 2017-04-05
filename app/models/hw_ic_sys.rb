class HwIcSys < ActiveRecord::Base
  self.table_name = 'hw_ic_sys'
  alias_attribute :id, primary_key
end
