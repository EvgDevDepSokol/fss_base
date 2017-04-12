class PdsMalfunctionDim < ApplicationRecord
  self.table_name = 'pds_malfunction_dim'
  alias_attribute :id, primary_key
  belongs_to :pds_malfunction, foreign_key: :Malfunction, class_name: 'PdsMalfunction'
  belongs_to :sd_sys_numb, foreign_key: 'sd_N'
  alias_attribute :pds_malfunction_id, :Malfunction
  alias_attribute :sd_sys_numb_id, :sd_N

  scope :ordered, -> { includes(:pds_malfunction).order('pds_malfunction.sys', 'pds_malfunction.Numb', 'pds_malfunction_dim.Character') }

  def plucked
    true
  end

  def custom_hash
    serializable_hash(include: {
                        pds_malfunction: { only: %i[sys Numb], include: { system: { only: :System } } },
                        sd_sys_numb: { only: [:sd_link] }
                      })
  end
end
