class PdsUnit < ActiveRecord::Base
  self.table_name = 'pds_unit'

  alias_attribute :ru, :Unit_RU
  alias_attribute :en, :Unit_EN

  def custom_hash
    serializable_hash.merge(id: id)
  end
end
