class PdsPpcd < ApplicationRecord
  self.table_name = 'pds_ppcd'
  include DbmGeneratorHelper
  alias_attribute :id, primary_key
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_detector, foreign_key: :Detector
  alias_attribute :system_id, :sys
  alias_attribute :pds_detector_id, :Detector

  def self.plucked
    pluck('ppcdID', 'pds_syslist.SystemID', 'pds_syslist.System',
      'Shifr', 'Key', 'identif',
      'Description', 'Description_EN',
      'pds_detectors.DetID', 'pds_detectors.tag').map do |e|
      {
        'id' => e[0],
        'system' => { System: e[2], id: e[1] },
        'Shifr' => e[3],
        'Key' => e[4],
        'identif' => e[5],
        'Description' => e[6],
        'Description_EN' => e[7],
        'pds_detector' => { id: e[8], tag: e[9] }
      }
    end
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
