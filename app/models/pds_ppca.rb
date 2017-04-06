class PdsPpca < ApplicationRecord
  self.table_name = 'pds_ppca'
  alias_attribute :id, primary_key
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_detector, foreign_key: :Detector
  alias_attribute :system_id, :sys
  alias_attribute :pds_detector_id, :Detector

  def custom_map
    true
  end

  def custom_hash
    serializable_hash(include: {
                        system: { only: :System },
                        pds_detector: { only: :tag }
                      })
  end

  def serializable_hash(options = {})
    super options.merge(methods: :id)
  end
end
