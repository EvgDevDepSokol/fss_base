# frozen_string_literal: true

class PdsUnit < ApplicationRecord
  self.table_name = 'pds_unit'
  alias_attribute :id, primary_key

  has_many :pds_project_units, dependent: :restrict_with_error, foreign_key: 'Unit', inverse_of: :pds_unit

  alias_attribute :ru, :Unit_RU
  alias_attribute :en, :Unit_EN

  def custom_hash
    serializable_hash.merge(id: id)
  end
end
