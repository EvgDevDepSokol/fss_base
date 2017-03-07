class PdsMathmodel < ActiveRecord::Base
  self.table_name = 'pds_mathmodel'
  alias_attribute :id, self.primary_key
end
