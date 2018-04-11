module EquipmentPanelsHelper
  # Helper for equipment panels tables

  private

  def set_sys_to_hw_ic(element)
    if element.sys != element.sys_was
      hw_ic = HwIc.find(element.IC)
      hw_ic.sys = element.sys
      hw_ic.save
    end
  end
end
