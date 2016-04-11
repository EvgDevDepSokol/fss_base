class Tablelist < ActiveRecord::Base

  self.table_name = 'tablelist'
  def custom_hash
    serializable_hash.merge({id: id})
  end

end
