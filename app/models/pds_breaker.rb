class PdsBreaker < ActiveRecord::Base
  alias_attribute :id, self.primary_key
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_project, foreign_key: 'Project'
  belongs_to :psa_ctrl_power, foreign_key: 'ctrl_power', class_name: 'PdsSectionAssembler'
  belongs_to :psa_anc_power, foreign_key: 'anc_power', class_name: 'PdsSectionAssembler'
  belongs_to :pds_man_equip, foreign_key: 'eq_type'
  belongs_to :sd_sys_numb, foreign_key: 'sd_N'

  alias_attribute :system_id, :sys
  alias_attribute :psa_ctrl_power_id, :ctrl_power
  alias_attribute :psa_anc_power_id, :anc_power
  alias_attribute :pds_man_equip_id, :eq_type
  alias_attribute :sd_sys_numb_id, :sd_N

  def custom_hash
    serializable_hash(include: {
                        system: { only: :System },
                        psa_ctrl_power: { only: :section_name },
                        psa_anc_power: { only: :section_name },
                        sd_sys_numb: { only: [:sd_link] }
                      })
  end
end
