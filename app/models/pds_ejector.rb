# frozen_string_literal: true

class PdsEjector < ApplicationRecord
  self.table_name = 'pds_ejector'
  alias_attribute :id, primary_key
  belongs_to :pds_project, foreign_key: 'Project'
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_man_equip, foreign_key: 'eq_type'
  belongs_to :pds_project_unit, foreign_key: :Unit, class_name: 'PdsProjectUnit'
  belongs_to :sd_sys_numb, foreign_key: 'sd_N', inverse_of: :pds_ejectors

  alias_attribute :system_id, :sys
  alias_attribute :pds_man_equip_id, :eq_type
  alias_attribute :pds_project_unit_id, :Unit
  alias_attribute :sd_sys_numb_id, :sd_N

  def custom_hash
    serializable_hash(include: {
                        system: { only: :System },
                        pds_project_unit: { only: [], include: { unit: { only: :Unit_RU } } },
                        pds_man_equip: { only: :Type },
                        sd_sys_numb: { only: [:sd_link] }
                      })
  end

  def serializable_hash(options = {})
    super options.merge(methods: :id)
  end
end
