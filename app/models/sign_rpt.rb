class SignRpt < ActiveRecord::Base
  self.table_name = 'sign_rpt'
  def custom_hash
    serializable_hash.merge(id: id)
  end
end
