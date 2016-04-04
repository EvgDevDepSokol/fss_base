class PdsBreaker < ActiveRecord::Base

  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_project, foreign_key: 'Project'
  belongs_to :psa_ctrl_power, foreign_key: 'ctrl_power', class_name: 'PdsSectionAssembler'
  #belongs_to :psa_ed_power, foreign_key: 'ed_power', class_name: 'PdsSectionAssembler'
  belongs_to :psa_anc_power, foreign_key: 'anc_power', class_name: 'PdsSectionAssembler'
  belongs_to :pds_man_equip, foreign_key: 'eq_type'
  belongs_to :pds_sd, foreign_key: 'sd_N'

  alias_attribute :system_id, :sys
  alias_attribute :psa_ctrl_power_id, :ctrl_power
  #alias_attribute :psa_ed_power_id, :ed_power
  alias_attribute :psa_anc_power_id, :anc_power
  alias_attribute :pds_man_equip_id, :eq_type
  alias_attribute :pds_sd_id, :sd_N

  def custom_hash
    serializable_hash(include: {
        system: {only: :System},
        psa_ctrl_power: {only: :section_name},
        #psa_ed_power: {only: :section_name},
        psa_anc_power: {only: :section_name} ,
        pds_sd: {only: :SdTitle}
      })
  end
 # # todo: fix system
 # def serializable_hash(options={})
 #   super.merge({id: id, system: system.to_s})
 # end
end
