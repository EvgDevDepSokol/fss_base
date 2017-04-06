class SdSysNumb < ApplicationRecord
  alias_attribute :id, primary_key
  self.table_name = 'sd_sys_numb'
  self.primary_key = 'sd_N'
end
