class EquipmentPanelsController < BaseController

  ACTIONS = [:hw_ic, :pds_bru, :pds_misc, :pds_set, :pds_switch_nofix, :pds_switch_fix,
    :pds_buttons, :pds_buttons_lights, :pds_lamps, :pds_mnemo, :pds_meters,
    :pds_meters_digital, :pds_alarm, :pds_recorders, :pds_announciator,
    :pds_meters_channels]

  def hw_ics
    @data_list = HwIc.where(Project: project.ProjectID).
      includes(hw_ped: [:hw_devtype], pds_panel: [])
  end

  def pds_brus
    @data_list = PdsBru.where(Project: project.ProjectID).
      includes({hw_ic: [:hw_ped]}, :system, :pds_section_assembler)
  end

  def pds_miscs
    @data_list = PdsMisc.where(Project: project.ProjectID).
      includes({hw_ic: [:hw_ped]}, :system, :pds_section_assembler)
  end

  def pds_sets
    @data_list = PdsSet.where(Project: project.ProjectID).
      includes({hw_ic: [:hw_ped]}, :system)
  end

  def pds_switch_nofixes
    @data_list = PdsSwitchNofix.where(Project: project.ProjectID).
      includes({hw_ic: [:hw_ped]}, :system)
  end

  def pds_switch_fixes
    @data_list = PdsSwitchFix.where(Project: project.ProjectID).
      includes({hw_ic: [:hw_ped]}, :system)
  end

  def pds_buttons
    @data_list = PdsButton.where(Project: project.ProjectID).
      includes({hw_ic: [:hw_ped]}, :system)
  end

  def pds_buttons_lights
    @data_list = PdsButtonsLight.where(Project: project.ProjectID).
      includes({hw_ic: [:hw_ped]}, :system, :pds_section_assembler)
  end

  def pds_lamps
    @data_list = PdsLamp.where(Project: project.ProjectID).
      includes({hw_ic: [:hw_ped]}, :system, :pds_section_assembler)
  end

  def pds_mnemos
    @data_list = PdsMnemo.where(Project: project.ProjectID).
      includes(:system, :pds_detector)
  end

  #todo: add unit to scope
  def pds_meters
    @data_list = PdsMeter.where(Project: project.ProjectID).
      includes({hw_ic: [:hw_ped]}, :system, :pds_section_assembler)
  end

  #todo: add unit to scope
  def pds_meters_digitals
    @data_list = PdsMetersDigital.where(Project: project.ProjectID).
      includes({hw_ic: [:hw_ped]}, :system, :pds_section_assembler)
  end

  def pds_alarms
    @data_list = PdsAlarm.where(Project: project.ProjectID).
      includes({hw_ic: [:hw_ped]}, :system)
  end

  def pds_recorders
    @data_list = PdsRecorder.where(Project: project.ProjectID).
      includes({hw_ic: [:hw_ped]}, :system, :pds_section_assembler)
  end

  def pds_announciators
    @data_list = PdsAnnounciator.where(Project: project.ProjectID).
      includes({hw_ic: [:hw_ped]}, :system, :pds_section_assembler, :pds_detector)
  end

  #todo: add unit to scope
  def pds_meters_channels
    @data_list = PdsMetersChannel.where(Project: project.ProjectID).
      includes({hw_ic: [:hw_ped]}, :system, :pds_section_assembler)
  end

end
