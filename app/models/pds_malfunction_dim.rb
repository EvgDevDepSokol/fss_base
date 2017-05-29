class PdsMalfunctionDim < ApplicationRecord
  self.table_name = 'pds_malfunction_dim'
  alias_attribute :id, primary_key
  belongs_to :pds_malfunction, foreign_key: :Malfunction, class_name: 'PdsMalfunction'
  belongs_to :sd_sys_numb, foreign_key: 'sd_N'
  alias_attribute :pds_malfunction_id, :Malfunction
  alias_attribute :sd_sys_numb_id, :sd_N

  scope :ordered, -> {
    includes(:pds_malfunction).order('pds_malfunction.sys', 'pds_malfunction.Numb',
      'pds_malfunction_dim.Character')
  }

  def self.plucked
    pluck(
      :MalfunctDimID, :Character, :Target, :Target_EN, :is_main,
      'pds_malfunction.MalfID', 'pds_syslist.SystemID', 'pds_syslist.System', 'pds_malfunction.Numb',
      'sd_sys_numb.sd_N', 'sd_sys_numb.sd_link'
    ).map do |e|
      {
        id:                e[0],
        Character:         e[1],
        Target:            e[2],
        Target_EN:         e[3],
        is_main:           e[4],
        pds_malfunction:   { id: e[5], system: { id: e[6], System: e[7] }, Numb: e[8] },
        sd_sys_numb:       { id: e[9], sd_link: e[10] },
        system:            { id: e[6], System: e[7] }
      }
    end
  end

  def custom_hash
    serializable_hash(include: {
                        pds_malfunction: { only: %i[sys Numb], include: { system: { only: :System } } },
                        sd_sys_numb: { only: [:sd_link] }
                      })
  end
end
