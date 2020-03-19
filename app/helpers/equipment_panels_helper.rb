# frozen_string_literal: true

module EquipmentPanelsHelper
  # Helper for equipment panels tables
  EQUIPMENT_TABLES = %i[pds_bru pds_misc pds_set pds_switch_nofix pds_switch_fix
                        pds_buttons pds_buttons_lights pds_lamps pds_mnemo pds_meters
                        pds_meters_digital pds_alarm pds_recorders pds_announciator
                        pds_meters_channels].freeze

  private

  def set_sys_to_hw_ic(element)
    if element.sys != element.sys_before_last_save
      hw_ic = HwIc.find(element.IC)
      hw_ic.sys = element.sys
      hw_ic.save
    end
  end
end
