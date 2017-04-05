class PdsNegotiator < ActiveRecord::Base
  alias_attribute :id, primary_key
  belongs_to :pds_project, foreign_key: 'Project'
  def custom_hash
    serializable_hash.merge(id: id)
  end
end
