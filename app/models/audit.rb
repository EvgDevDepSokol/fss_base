class Audit < ActiveRecord::Base

  self.table_name = 'audit'
  def custom_hash
    serializable_hash.merge({id: id})
  end

end
