# frozen_string_literal: true

class SdSysNumb < ApplicationRecord
  self.primary_key = 'sd_N'
  self.table_name = 'sd_sys_numb'
  alias_attribute :id, primary_key
  has_many :pds_detectors, dependent: :restrict_with_error, foreign_key: 'sd_N', inverse_of: :sd_sys_numb
  has_many :pds_malfunctions, dependent: :restrict_with_error, foreign_key: 'sd_N', inverse_of: :sd_sys_numb
  has_many :pds_malfunction_dims, dependent: :restrict_with_error, foreign_key: 'sd_N', inverse_of: :sd_sys_numb
  has_many :pds_motors, dependent: :restrict_with_error, foreign_key: 'sd_N', inverse_of: :sd_sys_numb
  has_many :pds_valves, dependent: :restrict_with_error, foreign_key: 'sd_N', inverse_of: :sd_sys_numb
  has_many :pds_breakers, dependent: :restrict_with_error, foreign_key: 'sd_N', inverse_of: :sd_sys_numb
  has_many :pds_equipment, dependent: :restrict_with_error, foreign_key: 'sd_N', inverse_of: :sd_sys_numb
  has_many :pds_filters, dependent: :restrict_with_error, foreign_key: 'sd_N', inverse_of: :sd_sys_numb
  has_many :pds_hex, dependent: :restrict_with_error, foreign_key: 'sd_N', inverse_of: :sd_sys_numb
  has_many :pds_regulators, dependent: :restrict_with_error, foreign_key: 'sd_N', inverse_of: :sd_sys_numb
  has_many :pds_rf, dependent: :restrict_with_error, foreign_key: 'sd_N', inverse_of: :sd_sys_numb
  has_many :pds_volumes, dependent: :restrict_with_error, foreign_key: 'sd_N', inverse_of: :sd_sys_numb
  has_many :pds_ejectors, dependent: :restrict_with_error, foreign_key: 'sd_N', inverse_of: :sd_sys_numb
end
