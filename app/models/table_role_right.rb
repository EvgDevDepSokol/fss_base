class TableRoleRight < ApplicationRecord
  self.table_name = 'table_role_rights'
  self.primary_key = 'tableID'
  alias_attribute :id, primary_key

  belongs_to :role, foreign_key: 'roleID'
  belongs_to :tablelist, foreign_key: 'tableID'

  alias_attribute :role_id, :roleID
  alias_attribute :tablelist_id, :tableID

  # TODO: fix primary key
  def custom_hash
    serializable_hash(include: {
                        role: { only: [:role] },
                        tablelist: { only: [:table] }
                      })
  end

  #  def serializable_hash(options={})
  #    super options.merge(methods: :id)
  #  end
end
