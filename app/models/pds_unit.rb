class PdsUnit < ActiveRecord::Base
  self.table_name = 'pds_unit'

  has_many :pds_project_unit, dependent: :restrict_with_error, foreign_key: 'Unit'

  alias_attribute :ru, :Unit_RU
  alias_attribute :en, :Unit_EN

  def custom_hash
    serializable_hash.merge(id: id)
  end
end
