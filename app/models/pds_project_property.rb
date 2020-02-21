# frozen_string_literal: true

class PdsProjectProperty < ApplicationRecord
  belongs_to :pds_project, foreign_key: 'ProjectID', inverse_of: :project_properties
  alias_attribute :id, primary_key

  alias_attribute :language, :Language

  def custom_hash
    serializable_hash(include: { pds_project: { only: :project_name } })
  end

  def serializable_hash(options = {})
    super options.merge(methods: :id)
  end
end
