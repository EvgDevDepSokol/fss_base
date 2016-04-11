class PdsNegotiator < ActiveRecord::Base

  belongs_to :pds_project, foreign_key: 'Project'
  def custom_hash
    serializable_hash.merge({id: id})
  end

end
