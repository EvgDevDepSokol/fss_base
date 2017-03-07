class PdsDr < ActiveRecord::Base
  self.table_name = 'pds_dr'
  alias_attribute :id, self.primary_key
end
