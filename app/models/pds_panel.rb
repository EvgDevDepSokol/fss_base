class PdsPanel < ApplicationRecord
  self.table_name = 'pds_panel'
  alias_attribute :id, primary_key

  enum pnl_type: {'BPU'=>'BPU','RPU' => 'RPU','PB' => 'PB','EL' => 'EL'}
  #validates :pnl_type, inclusion: %w[BPU RPU PB EL], allow_nil: true, allow_blank: true

  has_many :hw_ic, dependent: :restrict_with_error, foreign_key: 'panel_id'

  def to_s
    panel
  end

  def custom_hash
    serializable_hash.merge(id: id)
  end
end
