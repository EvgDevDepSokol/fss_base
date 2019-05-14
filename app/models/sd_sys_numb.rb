# frozen_string_literal: true

class SdSysNumb < ApplicationRecord
  self.primary_key = 'sd_N'
  self.table_name = 'sd_sys_numb'
  alias_attribute :id, primary_key
  has_many :pds_malfunction_dim, foreign_key: 'sd_N'
  has_many :pds_malfunction, foreign_key: 'sd_N'
end
