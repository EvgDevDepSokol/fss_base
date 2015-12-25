class TableRoleRight < ActiveRecord::Base

  self.table_name = 'table_role_rights'
  self.primary_key = 'tableID'

  # todo: fix primary key
  def custom_hash
    serializable_hash
  end

end
