class PdsSyslist < ApplicationRecord
  self.table_name = 'pds_syslist'
  alias_attribute :id, primary_key

  alias_attribute :title, :System

  has_many :hw_ic, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_air_valves, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_alarm, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_algorithms, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_announciator, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_blocks, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_blocks_systems, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_breakers, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_bru, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_buttons, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_buttons_lights, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_detectors, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_doc_on_sys, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_dr, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_dr_stats, dependent: :restrict_with_error, foreign_key: 'sys_id'
  has_many :pds_ejector, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_eng_on_sys, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_equipments, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_filter, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_hex, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_lamps, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_malfunction, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_mathmodel, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_meters, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_meters_channels, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_meters_digital, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_misc, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_mnemo, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_motors, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_ppca, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_ppcd, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_project_sys, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_queries, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_recorders, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_regulators, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_rf, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_sd, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_set, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_simplifications, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_switch_fix, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_switch_nofix, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_sys_description, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_valves, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :pds_volume, dependent: :restrict_with_error, foreign_key: 'sys'
  has_many :week_report, dependent: :restrict_with_error, foreign_key: 'sys'

  enum Descriptor: {'TH'=>'TH','L'=>'L','EL'=>'EL','CR'=>'CR','D'=>'D','addl'=>'addl'}
  enum Category:   {'1'=>'1','2'=>'2','3'=>'3'}

  def to_s
    self.System
  end

  def custom_hash
    serializable_hash.merge(id: id)
  end
end
