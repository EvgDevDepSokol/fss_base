# frozen_string_literal: true

class Company < ApplicationRecord
  self.table_name = 'company'
  alias_attribute :id, primary_key
  has_many :pds_projects, inverse_of: :company

  # logo хранится как bin obj
  def serializable_hash(_options = {})
    super(except: :Logo, methods: :id)
  end

  def custom_hash
    serializable_hash.merge(id: id)
  end
end
