class PdsPanel < ActiveRecord::Base

  self.table_name = 'pds_panel'

  def to_s
    panel
  end

  def custom_hash
    serializable_hash.merge({id: id})
  end

end
