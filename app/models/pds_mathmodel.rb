class PdsMathmodel < ActiveRecord::Base
  self.table_name = 'pds_mathmodel'
  alias_attribute :id, primary_key
end
