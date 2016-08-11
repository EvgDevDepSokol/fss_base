class PdsMalfunctionDim < ActiveRecord::Base
  self.table_name = 'pds_malfunction_dim'
  belongs_to :pds_malfunction, foreign_key: :Malfunction, class_name: 'PdsMalfunction'
  belongs_to :sd_sys_numb, foreign_key: 'sd_N'
  alias_attribute :pds_malfunction_id, :Malfunction
  alias_attribute :sd_sys_numb_id, :sd_N

  def custom_map
    true
  end
  def custom_hash
    serializable_hash(include:{
        pds_malfunction:{only: [:sys,:Numb], include: { system: { only: :System}}},
        sd_sys_numb: { only: [:sd_link] }
      }
    )
  end
end
