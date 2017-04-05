class PdsDr < ActiveRecord::Base
  self.table_name = 'pds_dr'
  alias_attribute :id, primary_key
end
