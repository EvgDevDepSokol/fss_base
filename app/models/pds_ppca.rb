class PdsPpca < ActiveRecord::Base
  self.table_name = 'pds_ppca'
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  alias_attribute :system_id, :sys

  def custom_map
    true
  end

  def custom_hash
    serializable_hash(include: {
                        system: { only: :System } })
  end

  def serializable_hash(options = {})
    super options.merge(methods: :id)
  end
end
