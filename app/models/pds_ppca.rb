# frozen_string_literal: true

class PdsPpca < ApplicationRecord
  self.table_name = 'pds_ppca'
  include DbmGeneratorHelper
  alias_attribute :id, primary_key
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_detector, foreign_key: :Detector
  alias_attribute :system_id, :sys
  alias_attribute :pds_detector_id, :Detector

  def custom_hash
    serializable_hash(include: {
                        system: { only: :System },
                        pds_detector: { only: :tag }
                      })
  end

  def serializable_hash(options = {})
    super options.merge(methods: :id)
  end

  def self.plucked
    pluck('ppcID', 'pds_syslist.SystemID', 'pds_syslist.System',
          'Shifr', 'Key', 'identif',
          'Description', 'Description_EN',
          'L_lim', 'U_lim', 'Unit', 'nom',
          'pds_detectors.DetID', 'pds_detectors.tag').map do |e|
      {
        id: e[0],
        system: { id: e[1], System: e[2] },
        Shifr: e[3],
        Key: e[4],
        identif: e[5],
        Description: e[6],
        Description_EN: e[7],
        L_lim: e[8],
        U_lim: e[9],
        Unit: e[10],
        nom: e[11],
        pds_detector: { id: e[12], tag: e[13] }
      }
    end
  end
end
