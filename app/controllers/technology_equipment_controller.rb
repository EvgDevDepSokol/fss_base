# frozen_string_literal: true

class TechnologyEquipmentController < BaseController
  # Technology equipment controller
  ACTIONS = %i[pds_detectors pds_motors pds_valves pds_regulators
               pds_ejector pds_hex pds_volume pds_filter pds_motor_type
               pds_man_equip pds_alg_type].freeze

  def pds_alg_types
    @data_list = PdsAlgType.where(Project: project.ProjectID)
  end

  def pds_detectors
    @data_list = PdsDetector.where(Project: project.ProjectID)
                            .includes(:system)
                            .includes(:pds_section_assembler,
                                      pds_project_unit: [:unit])
                            .includes(:sd_sys_numb)
                            .pluck(
                              :DetID,
                              :sys, # 'pds_syslist.SystemID',
                              'pds_syslist.System',
                              :tag, :tag_RU, :Desc, :Desc_EN,
                              'pds_section_assembler.section_N', 'pds_section_assembler.section_name',
                              :low_lim, :up_lim, :LA, :HA, :LW, :HW, :LT, :HT,
                              'pds_project_unit.ProjUnitID', 'pds_unit.UnitID', 'pds_unit.Unit_RU',
                              :'1coef_shift', :'2coef_scale', :Type, :TypeDetec, :Room, :SCK_input,
                              :mod,
                              'sd_sys_numb.sd_N', 'sd_sys_numb.sd_link'
                            ).map do |det_id, sys_id, syst, tag, tag_ru, desc, desc_en, psa_id, psa_n, low_lim, up_lim, la, ha, lw, hw, lt, ht, ppu_id, u_id, u_n, coef_shift, coef_scale, type, typedetec, room, sck_input, mod, ssn_id, ssn_l|
      { id: det_id, system: { id: sys_id, System: syst }, tag: tag, tag_RU: tag_ru, Desc: desc, Desc_EN: desc_en, pds_section_assembler: { id: psa_id, section_name: psa_n },
        low_lim: low_lim, up_lim: up_lim, LA: la, HA: ha, LW: lw, HW: hw, LT: lt, HT: ht, pds_project_unit: { id: ppu_id, unit: { id: u_id, Unit_RU: u_n } },
        '1coef_shift': coef_shift, '2coef_scale': coef_scale, Type: type, TypeDetec: typedetec, Room: room, SCK_input: sck_input, mod: mod,
        sd_sys_numb: { id: ssn_id, sd_link: ssn_l } }
    end
  end

  def pds_ejectors
    @data_list = PdsEjector.where(Project: project.ProjectID)
                           .includes(:system, :pds_man_equip)
                           .includes(:sd_sys_numb)
                           .includes(pds_project_unit: [:unit])
  end

  def pds_filters
    @data_list = PdsFilter.where(Project: project.ProjectID)
                          .includes(:system, :pds_man_equip)
                          .includes(:sd_sys_numb)
  end

  # TODO: проверить список возвращающихся значений
  def pds_hexes
    @data_list = PdsHex.where(Project: project.ProjectID)
                       .includes(:system, :pds_man_equip)
                       .includes(:sd_sys_numb)
                       .includes(pds_project_unit: [:unit])
  end

  def pds_man_equips
    @data_list = PdsManEquip.all.select(:EquipN, :Type, :Descriptor, :Comp_malf)
    # @data_list = PdsManEquip.all
  end

  def pds_motor_types
    @data_list = PdsMotorType.all
  end

  # :pds_man_equip, :pds_documentation)
  def pds_motors
    @data_list = PdsMotor.where(Project: project.ProjectID)
                         .includes(:system, :psa_ctrl_power, :psa_ed_power, :psa_anc_power,
                                   :sd_sys_numb, :pds_motor_type)
                         .pluck('MotID', 'tag_RU', :tag_EN, 'Desc_RU', 'Desc_EN', 'up_rate', 'down_rate', 'zmn',
                                'model', 'voltage', 'p_ust', 'i_nom', 'connection',
                                'pds_syslist.SystemID', 'pds_syslist.System',
                                'pds_section_assembler.section_N', 'pds_section_assembler.section_name',
                                'psa_ed_powers_pds_motors.section_N', 'psa_ed_powers_pds_motors.section_name',
                                'psa_anc_powers_pds_motors.section_N', 'psa_anc_powers_pds_motors.section_name',
                                'sd_sys_numb.sd_N', 'sd_sys_numb.sd_link',
                                'pds_motor_type.MotorTypeID', 'pds_motor_type.MotorType as PMotorType')

    @data_list = @data_list.each.map do |e|
      e1 = {}
      e1['id']               = e[0]
      e1['tag_RU']           = e[1]
      e1['tag_EN']           = e[2]
      e1['Desc_RU']          = e[3]
      e1['Desc_EN']          = e[4]
      e1['up_rate']          = e[5]
      e1['down_rate']        = e[6]
      e1['zmn']              = e[7]
      e1['model']            = e[8]
      e1['voltage']          = e[9]
      e1['p_ust']            = e[10]
      e1['i_nom']            = e[11]
      e1['connection']       = e[12]
      e1['system']           = { id: e[13], System: e[14] }
      e1['psa_ctrl_power']   = { id: e[15], section_name: e[16] }
      e1['psa_ed_power']     = { id: e[17], section_name: e[18] }
      e1['psa_anc_power']    = { id: e[19], section_name: e[20] }
      e1['sd_sys_numb']      = { id: e[21], sd_link: e[22] }
      e1['pds_motor_type']   = { id: e[23], MotorType: e[24] }
      e = e1
    end
  end

  def pds_regulators
    @data_list = PdsRegulator.where(Project: project.ProjectID)
                             .includes(:system)
                             .includes(:system, :psa_ctrl_power, :psa_ed_power, :psa_anc_power,
                                       :pds_man_equip, :pds_detector, :sd_sys_numb)
                             .pluck(:RegID, :tag_RU, :tag_EN, :station_sys, :Desc, :open_rate,
                                    :close_rate, :Algorithm, :model, :Desc_EN, :det_id, :par_val,
                                    'pds_syslist.SystemID', 'pds_syslist.System',
                                    'pds_section_assembler.section_N', 'pds_section_assembler.section_name',
                                    'psa_ed_powers_pds_regulators.section_N', 'psa_ed_powers_pds_regulators.section_name',
                                    'psa_anc_powers_pds_regulators.section_N', 'psa_anc_powers_pds_regulators.section_name',
                                    'sd_sys_numb.sd_N', 'sd_sys_numb.sd_link',
                                    'pds_man_equip.EquipN', 'pds_man_equip.Type')

    @data_list = @data_list.each.map do |e|
      e1 = {}
      e1['id']               = e[0]
      e1['tag_RU']           = e[1]
      e1['tag_EN']           = e[2]
      e1['station_sys']      = e[3]
      e1['Desc']             = e[4]
      e1['open_rate']        = e[5]
      e1['close_rate']       = e[6]
      e1['Algorithm']        = e[7]
      e1['model']            = e[8]
      e1['Desc_EN']          = e[9]
      e1['det_id']           = e[10]
      e1['par_val']          = e[11]
      e1['system']           = { id: e[12], System: e[13] }
      e1['psa_ctrl_power']   = { id: e[14], section_name: e[15] }
      e1['psa_ed_power']     = { id: e[16], section_name: e[17] }
      e1['psa_anc_power']    = { id: e[18], section_name: e[19] }
      e1['sd_sys_numb']      = { id: e[20], sd_link: e[21] }
      e1['pds_man_equip']    = { id: e[22], Type: e[23] }

      e = e1
    end
  end

  def pds_valves
    @data_list = PdsValf.where(Project: project.ProjectID)
                        .includes(:system, :psa_ctrl_power, :psa_ed_power, :psa_anc_power,
                                  :pds_man_equip, :pds_documentation)
                        .includes(:sd_sys_numb)
                        .pluck(
                          :valveID, :tag_RU, :tag_EN, :Type, :Desc, :Desc_EN, :Department,
                          :PowerTemp, :open_rate, :close_rate, :Algorithm,
                          :model, :room, :connection,
                          'pds_syslist.SystemID', 'pds_syslist.System',
                          'pds_section_assembler.section_N', 'pds_section_assembler.section_name',
                          'psa_ed_powers_pds_valves.section_N', 'psa_ed_powers_pds_valves.section_name',
                          'psa_anc_powers_pds_valves.section_N', 'psa_anc_powers_pds_valves.section_name',
                          'sd_sys_numb.sd_N', 'sd_sys_numb.sd_link'
                        )

    @data_list = @data_list.each.map do |e|
      e1 = {}
      e1['id']               = e[0]
      e1['tag_RU']           = e[1]
      e1['tag_EN']           = e[2]
      e1['Type']             = e[3]
      e1['Desc']             = e[4]
      e1['Desc_EN']          = e[5]
      e1['Department']       = e[6]
      e1['PowerTemp']        = e[7]
      e1['open_rate']        = e[8]
      e1['close_rate']       = e[9]
      e1['Algorithm']        = e[10]
      e1['model']            = e[11]
      e1['room']             = e[12]
      e1['connection']       = e[13]
      e1['system']           = { id: e[14], System: e[15] }
      e1['psa_ctrl_power']   = { id: e[16], section_name: e[17] }
      e1['psa_ed_power']     = { id: e[18], section_name: e[19] }
      e1['psa_anc_power']    = { id: e[20], section_name: e[21] }
      e1['sd_sys_numb']      = { id: e[22], sd_link: e[23] }

      e = e1
    end
  end

  def pds_volumes
    @data_list = PdsVolume.where(Project: project.ProjectID)
                          .includes(:system, :pds_man_equip)
                          .includes(:sd_sys_numb)
  end

  helper_method :table_header

  Oj.default_options = { mode: :compat }
  def table_header
    Oj.dump(model_class.attribute_names.map { |attr| { property: attr, header: attr } })
  end
end
