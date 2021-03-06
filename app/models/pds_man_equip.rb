# frozen_string_literal: true

class PdsManEquip < ApplicationRecord
  self.table_name = 'pds_man_equip'
  alias_attribute :id, primary_key

  alias_attribute :type, :Type
  alias_attribute :id, :EquipN

  has_many :pds_breakers, dependent: :restrict_with_error, foreign_key: 'eq_type'
  has_many :pds_detectors, dependent: :restrict_with_error, foreign_key: 'eq_type', inverse_of: :pds_man_equip
  has_many :pds_ejector, dependent: :restrict_with_error, foreign_key: 'eq_type'
  has_many :pds_equipments, dependent: :restrict_with_error, foreign_key: 'eq_type'
  has_many :pds_filter, dependent: :restrict_with_error, foreign_key: 'eq_type'
  has_many :pds_hex, dependent: :restrict_with_error, foreign_key: 'eq_type'
  has_many :pds_motors, dependent: :restrict_with_error, foreign_key: 'eq_type'
  has_many :pds_regulators, dependent: :restrict_with_error, foreign_key: 'eq_type'
  has_many :pds_valves, dependent: :restrict_with_error, foreign_key: 'eq_type'
  has_many :pds_volume, dependent: :restrict_with_error, foreign_key: 'eq_type'

  def custom_hash
    serializable_hash(methods: %i[id Type Descriptor Comp_malf])
  end
end
