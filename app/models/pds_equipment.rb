class PdsEquipment < ActiveRecord::Base

  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_project, foreign_key: 'Project'
  belongs_to :pds_sd, foreign_key: 'sd_N'
  belongs_to :pds_man_equip, foreign_key: 'eq_type'
  belongs_to :pds_equip, foreign_key: 'type_equip'


  alias_attribute :system_id, :sys
  alias_attribute :pds_sd_id, :sd_N
  alias_attribute :pds_man_equip_id, :eq_type
  alias_attribute :pds_equip_id, :type_equip
  def custom_hash
    serializable_hash(include: {
        system: {only: :System},
        pds_sd: {only: :SdTitle},
        pds_man_equip: {only: :Type},
        pds_equip: {only: :typeE}
      })
  end

  #def serializable_hash(options={})
  #  super.merge({id: id, system: system.to_s})
  #end

end
