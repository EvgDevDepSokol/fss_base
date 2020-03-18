# frozen_string_literal: true

class PdsProjectUnit < ApplicationRecord
  self.table_name = 'pds_project_unit'
  alias_attribute :id, primary_key
  belongs_to :pds_project, foreign_key: 'Project'
  belongs_to :unit, foreign_key: 'Unit', class_name: 'PdsUnit'

  alias_attribute :pds_unit_id, :Unit

  has_many :hw_ics, dependent: :restrict_with_error, foreign_key: 'Unit', inverse_of: :pds_project_unit
  has_many :hw_wirelist, dependent: :restrict_with_error, foreign_key: 'Unit'
  # has_many :pds_algo_inputs, dependent: :restrict_with_error, foreign_key: 'Unit'
  # has_many :pds_algo_outs, dependent: :restrict_with_error, foreign_key: 'Unit'
  has_many :pds_detectors, dependent: :restrict_with_error, foreign_key: 'Unit', inverse_of: :pds_project_unit
  has_many :pds_malfunction, dependent: :restrict_with_error, foreign_key: 'regidity_unitid'
  has_many :pds_ppca, dependent: :restrict_with_error, foreign_key: 'UnitID'
  has_many :pds_rf, dependent: :restrict_with_error, foreign_key: 'Unit'
  has_many :pds_ejector, dependent: :restrict_with_error, foreign_key: 'Unit'
  has_many :pds_rf, dependent: :restrict_with_error, foreign_key: 'unit_FB'

  def custom_hash
    serializable_hash(include:
        { unit: { only: %i[Unit_RU Unit_EN] } })
  end
end
