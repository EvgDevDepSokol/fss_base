# frozen_string_literal: true

class EquipmentPanelsController < BaseController
  # Controller for Equipment panels
  ACTIONS = %i[hw_ic pds_bru pds_misc pds_set pds_switch_nofix pds_switch_fix
               pds_buttons pds_buttons_lights pds_lamps pds_mnemo pds_meters
               pds_meters_digital pds_alarm pds_recorders pds_announciator
               pds_meters_channels].freeze

  #  def hw_ics
  #    @data_list = HwIc.where(Project: project.ProjectID).select(
  #      :icID, :ref, :Description, :scaleMin, :scaleMax, :tag_no,
  #      :UniquePTAG, :un, :panel, :Description_EN, :rev, :sys, :ped, :Unit)
  #      .includes(:system, hw_ped: [:hw_devtype], pds_panel: [], pds_project_unit: [:unit])
  #  end

  #                   .includes(hw_ped: [:hw_devtype])
  #                   .joins('LEFT OUTER JOIN hw_ic_sys ON hw_ic_sys.IC = hw_ic.icID')
  #                   .joins('LEFT OUTER JOIN pds_syslist ON pds_syslist.SystemID = hw_ic_sys.sys').order(:ref)
  def hw_ics
    # @data_list = HwIc.where(Project: project.ProjectID)
    #                 .includes(pds_panel: [], pds_project_unit: [:unit])
    #                 .includes({ hw_ped: [:hw_devtype] }, :system)
    #                 .pluck(
    #                   :icID, :ref,
    #                   'pds_syslist.SystemID', 'pds_syslist.System',
    #                   :Description,
    #                   'hw_peds.ped_N', 'hw_peds.ped', 'hw_devtype.typeID', 'hw_devtype.RuName',
    #                   :scaleMin, :scaleMax,
    #                   'pds_project_unit.ProjUnitID', 'pds_unit.UnitID', 'pds_unit.Unit_RU',
    #                   :tag_no, :UniquePTAG, :un, :Description_EN, :rev,
    #                   'pds_panel.pID', 'pds_panel.panel'
    #                 )
    sql = "SELECT `hw_ic`.`icID`, `hw_ic`.`ref`, pds_syslist.SystemID, pds_syslist.System, `hw_ic`.`Description`, hw_peds.ped_N, hw_peds.ped, hw_devtype.typeID, hw_devtype.RuName, `hw_ic`.`scaleMin`, `hw_ic`.`scaleMax`, pds_project_unit.ProjUnitID, pds_unit.UnitID, pds_unit.Unit_RU, `hw_ic`.`tag_no`, `hw_ic`.`UniquePTAG`, `hw_ic`.`un`, `hw_ic`.`Description_EN`, `hw_ic`.`rev`, pds_panel.pID, pds_panel.panel, date_format(hw_ic.t,'%Y-%m-%d %H:%i') FROM `hw_ic` LEFT OUTER JOIN `pds_panel` ON `pds_panel`.`pID` = `hw_ic`.`panel_id` LEFT OUTER JOIN `pds_project_unit` ON `pds_project_unit`.`ProjUnitID` = `hw_ic`.`Unit` LEFT OUTER JOIN `pds_unit` ON `pds_unit`.`UnitID` = `pds_project_unit`.`Unit` LEFT OUTER JOIN `hw_peds` ON `hw_peds`.`ped_N` = `hw_ic`.`ped` LEFT OUTER JOIN `hw_devtype` ON `hw_devtype`.`typeID` = `hw_peds`.`type` LEFT OUTER JOIN `pds_syslist` ON `pds_syslist`.`SystemID` = `hw_ic`.`sys` WHERE `hw_ic`.`Project` = #{project.ProjectID}"
    @data_list = ActiveRecord::Base.connection.execute(sql).each.map do |e|
      e1 = {}
      e1['id']               = e[0]
      e1['ref']              = e[1]
      e1['system']           = { id: e[2], System: e[3] }
      e1['Description']      = e[4]
      e1['hw_ped']           = { id: e[5], ped: e[6], hw_devtype: { id: e[7], RuName: e[8] } }
      e1['scaleMin']         = e[9]
      e1['scaleMax']         = e[10]
      e1['pds_project_unit'] = { id: e[11], unit: { id: e[12], Unit_RU: e[13] } }
      e1['tag_no']           = e[14]
      e1['UniquePTAG']       = e[15]
      e1['un']               = e[16]
      e1['Description_EN']   = e[17]
      e1['rev']              = e[18]
      e1['pds_panel']        = { id: e[19], panel: e[20] }
      e1['t']                = e[21]
      e = e1
    end
  end

  def pds_brus
    @data_list = PdsBru.where(Project: project.ProjectID)
                       .includes({ hw_ic: [:hw_ped] }, :system, :pds_section_assembler).order('hw_ic.ref')
  end

  def pds_miscs
    @data_list = PdsMisc.where(Project: project.ProjectID)
                        .includes({ hw_ic: [:hw_ped] }, :system, :pds_section_assembler).order('hw_ic.ref')
  end

  def pds_sets
    @data_list = PdsSet.where(Project: project.ProjectID)
                       .includes({ hw_ic: [:hw_ped] }, :system).order('hw_ic.ref')
  end

  def pds_switch_nofixes
    @data_list = PdsSwitchNofix.where(Project: project.ProjectID)
                               .includes({ hw_ic: [:hw_ped] }, :system).order('hw_ic.ref')
                               .pluck(
                                 :KeyID,
                                 'hw_ic.icID', 'hw_ic.ref', 'hw_ic.tag_no', 'hw_ic.Description',
                                 'hw_peds.ped_N', :'hw_peds.ped',
                                 'pds_syslist.SystemID', 'pds_syslist.System',
                                 'range'
                               ).each.map do |e|
      e1 = {}
      e1['id']               = e[0]
      e1['hw_ic']            = { id: e[1], ref: e[2], tag_no: e[3], Description: e[4], hw_ped: { id: e[5], ped: e[6] } }
      e1['system']           = { id: e[7], System: e[8] }
      e1['range']            = e[9]
      e = e1
    end
  end

  def pds_switch_fixes
    @data_list = PdsSwitchFix.where(Project: project.ProjectID)
                             .includes({ hw_ic: [:hw_ped] }, :system).order('hw_ic.ref')
                             .pluck(
                               :KeyID,
                               'hw_ic.icID', 'hw_ic.ref', 'hw_ic.tag_no', 'hw_ic.Description',
                               'hw_peds.ped_N', :'hw_peds.ped',
                               'pds_syslist.SystemID', 'pds_syslist.System',
                               'range'
                             ).each.map do |e|
      e1 = {}
      e1['id']               = e[0]
      e1['hw_ic']            = { id: e[1], ref: e[2], tag_no: e[3], Description: e[4], hw_ped: { id: e[5], ped: e[6] } }
      e1['system']           = { id: e[7], System: e[8] }
      e1['range']            = e[9]
      e = e1
    end
  end

  def pds_buttons
    @data_list = PdsButton.where(Project: project.ProjectID)
                          .includes({ hw_ic: [:hw_ped] }, :system).order('hw_ic.ref')
                          .pluck(
                            :ButtonID,
                            'hw_ic.icID', 'hw_ic.ref', 'hw_ic.tag_no', 'hw_ic.Description',
                            'hw_peds.ped_N', :'hw_peds.ped',
                            'pds_syslist.SystemID', 'pds_syslist.System',
                            'range', 'Fixed'
                          ).each.map do |e|
      e1 = {}
      e1['id']               = e[0]
      e1['hw_ic']            = { id: e[1], ref: e[2], tag_no: e[3], Description: e[4], hw_ped: { id: e[5], ped: e[6] } }
      e1['system']           = { id: e[7], System: e[8] }
      e1['range']            = e[9]
      e1['Fixed']            = e[10]
      e = e1
    end
  end

  def pds_buttons_lights
    @data_list = PdsButtonsLight.where(Project: project.ProjectID)
                                .includes({ hw_ic: [:hw_ped] }, :system, :pds_section_assembler).order('hw_ic.ref')
                                .pluck(
                                  :ButtonID,
                                  'hw_ic.icID', 'hw_ic.ref', 'hw_ic.tag_no', 'hw_ic.Description',
                                  'hw_peds.ped_N', :'hw_peds.ped',
                                  'pds_syslist.SystemID', 'pds_syslist.System',
                                  'pds_section_assembler.section_N', 'pds_section_assembler.section_name',
                                  'range', 'Fixed'
                                ).each.map do |e|
      e1 = {}
      e1['id']                    = e[0]
      e1['hw_ic']                 = { id: e[1], ref: e[2], tag_no: e[3], Description: e[4],
                                      hw_ped: { id: e[5], ped: e[6] } }
      e1['system']                = { id: e[7], System: e[8] }
      e1['pds_section_assembler'] = { id: e[9], section_name: e[10] }
      e1['range']                 = e[11]
      e1['Fixed']                 = e[12]
      e = e1
    end
  end

  def pds_lamps
    @data_list = PdsLamp.where(Project: project.ProjectID)
                        .includes({ hw_ic: [:hw_ped] }, :system, :pds_section_assembler).order('hw_ic.ref')
                        .pluck(
                          :LampID,
                          'hw_ic.icID', 'hw_ic.ref', 'hw_ic.tag_no', 'hw_ic.Description',
                          'hw_peds.ped_N', :'hw_peds.ped',
                          'pds_syslist.SystemID', 'pds_syslist.System',
                          'pds_section_assembler.section_N', 'pds_section_assembler.section_name'
                        ).each.map do |e|
      e1 = {}
      e1['id']                    = e[0]
      e1['hw_ic']                 = { id: e[1], ref: e[2], tag_no: e[3], Description: e[4],
                                      hw_ped: { id: e[5], ped: e[6] } }
      e1['system']                = { id: e[7], System: e[8] }
      e1['pds_section_assembler'] = { id: e[9], section_name: e[10] }
      e = e1
    end
  end

  def pds_mnemos
    @data_list = PdsMnemo.where(Project: project.ProjectID)
                         .includes(:system, :pds_detector)
  end

  # TODO: add unit to scope
  def pds_meters
    @data_list = PdsMeter.where(Project: project.ProjectID)
                         .includes({ hw_ic: [:hw_ped, pds_project_unit: :unit] }, :system, :pds_section_assembler)
  end

  # TODO: add unit to scope
  def pds_meters_digitals
    @data_list = PdsMetersDigital.where(Project: project.ProjectID)
                                 .includes({ hw_ic: [:hw_ped, pds_project_unit: :unit] }, :system,
                                           :pds_section_assembler)
                                 .pluck(:MetDigID,
                                        'hw_ic.icID', 'hw_ic.ref', 'hw_ic.tag_no', 'hw_ic.Description',
                                        'hw_peds.ped_N', 'hw_peds.ped',
                                        'pds_syslist.SystemID', 'pds_syslist.System',
                                        'pds_section_assembler.section_N', 'pds_section_assembler.section_name',
                                        'hw_ic.scaleMin', 'hw_ic.scaleMax',
                                        'pds_project_unit.ProjUnitID', 'pds_unit.UnitID', 'pds_unit.Unit_RU').each.map do |e|
      e1 = {}
      e1['id']                    = e[0]
      e1['hw_ic']                 = { id: e[1], ref: e[2], tag_no: e[3], Description: e[4],
                                      hw_ped: { id: e[5], ped: e[6] }, scaleMin: e[11], scaleMax: e[12],
                                      pds_project_unit: { id: e[13], unit: { id: e[14], Unit_RU: e[15] } } }
      e1['system']                = { id: e[7], System: e[8] }
      e1['pds_section_assembler'] = { id: e[9], section_name: e[10] }
      e = e1
    end
  end

  def pds_alarms
    @data_list = PdsAlarm.where(Project: project.ProjectID)
                         .includes({ hw_ic: [:hw_ped] }, :system).order('hw_ic.ref')
  end

  def pds_recorders
    @data_list = PdsRecorder.where(Project: project.ProjectID)
                            .includes({ hw_ic: [:hw_ped] }, :system, :pds_section_assembler).order('hw_ic.ref')
  end

  def pds_announciators
    @data_list = PdsAnnounciator.where(Project: project.ProjectID)
                                .includes({ hw_ic: [:hw_ped] }, :system, :pds_section_assembler, :pds_detector)
                                .order('hw_ic.ref')
                                .pluck(
                                  :AnnouncID,
                                  'hw_ic.icID', 'hw_ic.ref', 'hw_ic.tag_no', 'hw_ic.Description',
                                  'hw_peds.ped_N', :'hw_peds.ped',
                                  'pds_syslist.SystemID', 'pds_syslist.System',
                                  'pds_section_assembler.section_N', 'pds_section_assembler.section_name',
                                  'pds_detectors.DetID', 'pds_detectors.tag',
                                  'Type', 'sign'
                                ).each.map do |e|
      e1 = {}
      e1['id']                    = e[0]
      e1['hw_ic']                 = { id: e[1], ref: e[2], tag_no: e[3], Description: e[4],
                                      hw_ped: { id: e[5], ped: e[6] } }
      e1['system']                = { id: e[7], System: e[8] }
      e1['pds_section_assembler'] = { id: e[9], section_name: e[10] }
      e1['pds_detector']          = { id: e[11], tag: e[12] }
      e1['Type']                  = e[13]
      e1['sign']                  = e[14]
      e = e1
    end
  end

  def pds_meters_channels
    @data_list = PdsMetersChannel.where(Project: project.ProjectID)
                                 .includes({ hw_ic: [:hw_ped, pds_project_unit: :unit] }, :system,
                                           :pds_section_assembler)
  end
end
