class SignRpt < ActiveRecord::Base
  self.table_name = 'sign_rpt'
  alias_attribute :id, self.primary_key
  def custom_hash
    serializable_hash.merge(id: id)
  end
end
