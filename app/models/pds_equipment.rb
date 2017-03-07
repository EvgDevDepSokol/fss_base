class PdsEquipment < ActiveRecord::Base
  alias_attribute :id, self.primary_key
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_project, foreign_key: 'Project'
  belongs_to :pds_man_equip, foreign_key: 'eq_type'
  belongs_to :pds_equip, foreign_key: 'type_equip'
  belongs_to :sd_sys_numb, foreign_key: 'sd_N'

  alias_attribute :system_id, :sys
  alias_attribute :pds_man_equip_id, :eq_type
  alias_attribute :pds_equip_id, :type_equip
  alias_attribute :sd_sys_numb_id, :sd_N
  def custom_hash
    serializable_hash(include: {
                        system: { only: :System },
                        pds_man_equip: { only: :Type },
                        pds_equip: { only: :typeE },
                        sd_sys_numb: { only: [:sd_link] }
                      })
  end
end
