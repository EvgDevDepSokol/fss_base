class Role < ActiveRecord::Base
  self.table_name = 'roles'
  self.primary_key = 'roleID'

  def custom_hash
    serializable_hash
  end
end

