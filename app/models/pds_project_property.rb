class PdsProjectProperty < ApplicationRecord
  belongs_to :pds_project, foreign_key: 'ProjectID'
  alias_attribute :id, primary_key

  alias_attribute :language, :Language

  def custom_hash
    serializable_hash.merge(id: id)
  end
end
