class PdsPanel < ActiveRecord::Base
  self.table_name = 'pds_panel'
  alias_attribute :id, self.primary_key

  has_many :hw_ic, dependent: :restrict_with_error, foreign_key: 'panel_id'

  def to_s
    panel
  end

  def custom_hash
    serializable_hash.merge(id: id)
  end
end
