class PdsSd < ApplicationRecord
  self.table_name = 'pds_sd'
  alias_attribute :id, primary_key

  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  alias_attribute :system_id, :sys
  # alias_attribute :title, :SdTitle

  has_many :pds_breakers, dependent: :restrict_with_error, foreign_key: 'sd_N'
  has_many :pds_detectors, dependent: :restrict_with_error, foreign_key: 'sd_N'
  has_many :pds_ejector, dependent: :restrict_with_error, foreign_key: 'sd_N'
  has_many :pds_equipments, dependent: :restrict_with_error, foreign_key: 'sd_N'
  has_many :pds_filter, dependent: :restrict_with_error, foreign_key: 'sd_N'
  has_many :pds_hex, dependent: :restrict_with_error, foreign_key: 'sd_N'
  has_many :pds_malfunction, dependent: :restrict_with_error, foreign_key: 'sd_N'
  has_many :pds_malfunction_dim, dependent: :restrict_with_error, foreign_key: 'sd_N'
  has_many :pds_motors, dependent: :restrict_with_error, foreign_key: 'sd_N'
  has_many :pds_regulators, dependent: :restrict_with_error, foreign_key: 'sd_N'
  has_many :pds_rf, dependent: :restrict_with_error, foreign_key: 'sd_N'
  has_many :pds_valves, dependent: :restrict_with_error, foreign_key: 'sd_N'
  has_many :pds_volume, dependent: :restrict_with_error, foreign_key: 'sd_N'

  def custom_map
    true
  end
  def custom_hash
    serializable_hash(include: {
                        system: { only: :System }
                      })
  end

  before_save do |pds_sd|
    pds_sd.Numb = pds_sd.Numb.rjust(2, '0')
  end
end
