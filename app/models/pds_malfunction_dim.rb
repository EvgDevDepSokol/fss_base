class PdsMalfunctionDim < ActiveRecord::Base
  self.table_name = 'pds_malfunction_dim'
  belongs_to :pds_malfunction, foreign_key: :Malfunction, class_name: 'PdsMalfunction'
  alias_attribute :pds_malfunction_id, :Malfunction

  def custom_hash
    serializable_hash(include:{
        pds_malfunction:{only: [:sys,:Numb], include: { system: { only: :System}}}
      }
    )
  end
end
