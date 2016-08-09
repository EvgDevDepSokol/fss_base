class PdsDocumentation < ActiveRecord::Base
  self.table_name = 'pds_documentation'

  def custom_hash
    serializable_hash.merge(id: id)
  end
end
