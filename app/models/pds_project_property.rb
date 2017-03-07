class PdsProjectProperty < ActiveRecord::Base
  belongs_to :pds_project, foreign_key: 'ProjectID'
  alias_attribute :id, self.primary_key

  alias_attribute :language, :Language

  def custom_hash
    serializable_hash.merge(id: id)
  end
end
