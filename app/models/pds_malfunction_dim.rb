class PdsMalfunctionDim < ActiveRecord::Base

  self.table_name = 'pds_malfunction_dim'

  def serializable_hash(options={})
    super.merge({id: id})
  end

end
