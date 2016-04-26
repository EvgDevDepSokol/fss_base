class PdsFilter < ActiveRecord::Base
  self.table_name = 'pds_filter'
  belongs_to :pds_project, foreign_key: 'Project'
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_man_equip, foreign_key: 'eq_type'
  belongs_to :pds_sd, foreign_key: 'sd_N'

  alias_attribute :system_id, :sys
  alias_attribute :pds_man_equip_id, :eq_type
  alias_attribute :pds_sd_id, :sd_N

  def custom_hash
    serializable_hash(include: {
                        system: { only: :System },
                        pds_man_equip: { only: :Type },
                        pds_sd: { only: :SdTitle }
                      })
  end

  def serializable_hash(options = {})
    super options.merge(methods: :id)
  end
end
