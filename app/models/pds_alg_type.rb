# frozen_string_literal: true

class PdsAlgType < ApplicationRecord
  self.table_name = 'pds_alg_type'
  alias_attribute :id, primary_key
  belongs_to :pds_project, foreign_key: 'Project'

  def custom_hash
    serializable_hash
  end

  def serializable_hash(options = {})
    super options.merge(methods: :id)
  end
end
