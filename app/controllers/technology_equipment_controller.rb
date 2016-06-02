class TechnologyEquipmentController < BaseController
  ACTIONS = [:pds_detectors, :pds_motors, :pds_valves, :pds_regulators,
             :pds_ejector, :pds_hex, :pds_volume, :pds_filter, :pds_motor_type,
             :pds_man_equip, :pds_alg_type].freeze

  def pds_alg_types
    @data_list = PdsAlgType.where(Project: project.ProjectID)
  end
  #  def pds_detectors
  #    @data_list = PdsDetector.where(Project: project.ProjectID).select(
  #      :DetID, :Project, :sys, :tag, :tag_RU, :Desc, :Desc_EN,
  #      :ctrl_power, :low_lim, :up_lim, :LA, :HA, :LW,
  #      :HW, :LT, :HT, :Unit, :'1coef_shift', :'2coef_scale',
  #      :sd_N, :doc_reg_N, :t, :Type, :TypeDetec, :Room, :SCK_input,
  #      :power,
  #      :import_t, :mod, :eq_type).
  #      includes(:system, :pds_section_assembler,
  #               :pds_man_equip, :pds_sd, pds_project_unit: [:unit])
  #  end

  def pds_detectors
    @data_list = PdsDetector.where(Project: project.ProjectID)
                            .includes(
                              :system, :pds_section_assembler,
                              :pds_sd, pds_project_unit: [:unit])
                            .pluck(
                              :DetID,
                              'pds_syslist.SystemID', 'pds_syslist.System',
                              :tag, :tag_RU, :Desc, :Desc_EN,
                              'pds_section_assembler.section_N', 'pds_section_assembler.section_name',
                              :low_lim, :up_lim, :LA, :HA, :LW, :HW, :LT, :HT,
                              'pds_project_unit.ProjUnitID', 'pds_unit.UnitID', 'pds_unit.Unit_RU',
                              :'1coef_shift', :'2coef_scale', :Type, :TypeDetec, :Room, :SCK_input,
                              :mod,
                              'pds_sd.sd_N', 'pds_sd.SdTitle')

    @data_list = @data_list.each.map do |e|
      e1 = {}
      e1['id']               = e[0]
      e1['system']           = { id: e[1], System: e[2] }
      e1['tag']              = e[3]
      e1['tag_RU']           = e[4]
      e1['Desc']             = e[5]
      e1['Desc_EN']          = e[6]
      e1['pds_section_assembler'] = { id: e[7], section_name: e[8] }
      e1['low_lim']          = e[9]
      e1['up_lim']           = e[10]
      e1['LA']               = e[11]
      e1['HA']               = e[12]
      e1['LW']               = e[13]
      e1['HW']               = e[14]
      e1['LT']               = e[15]
      e1['HT']               = e[16]
      e1['pds_project_unit'] = { id: e[17], unit: { id: e[18], Unit_RU: e[19] } }
      e1['1coef_shift']      = e[20]
      e1['2coef_scale']      = e[21]
      e1['Type']             = e[22]
      e1['TypeDetec']        = e[23]
      e1['Room']             = e[24]
      e1['SCK_input']        = e[25]
      e1['mod']              = e[26]
      e1['pds_sd']           = { id: e[27], SdTitle: e[28] }

      e = e1
    end
  end

  def pds_ejectors
    @data_list = PdsEjector.where(Project: project.ProjectID)
                           .includes(:system, :pds_man_equip, :pds_sd)
                           .includes(pds_project_unit: [:unit])
  end

  def pds_filters
    @data_list = PdsFilter.where(Project: project.ProjectID)
                          .includes(:system, :pds_man_equip, :pds_sd)
  end

  # TODO: проверить список возвращающихся значений
  def pds_hexes
    @data_list = PdsHex.where(Project: project.ProjectID)
                       .includes(:system, :pds_man_equip, :pds_sd)
                       .includes(pds_project_unit: [:unit])
  end

  def pds_man_equips
    @data_list = PdsManEquip.all.select(:EquipN, :Type, :Descriptor, :Comp_malf)
    # @data_list = PdsManEquip.all
  end

  def pds_motor_types
    @data_list = PdsMotorType.all
  end

  def pds_motors
    @data_list = PdsMotor.where(Project: project.ProjectID)
                         .includes(:system, :psa_ctrl_power, :psa_ed_power, :psa_anc_power,
                                   :pds_motor_type,
                                   :pds_man_equip, :pds_sd, :pds_documentation)
  end

  def pds_regulators
    @data_list = PdsRegulator.where(Project: project.ProjectID)
                             .includes(:system, :psa_ctrl_power, :psa_ed_power, :psa_anc_power,
                                       :pds_man_equip, :pds_sd, :pds_documentation, :value_1,
                                       :value_2, :pds_detector)
  end

  def pds_valves
    @data_list = PdsValf.where(Project: project.ProjectID)
                        .includes(:system, :psa_ctrl_power, :psa_ed_power, :psa_anc_power,
                                  :pds_man_equip, :pds_sd, :pds_documentation)
                        .pluck(
                          :valveID, :tag_RU, :tag_EN, :Type, :Desc, :Desc_EN, :Department,
                          :PowerTemp, :open_rate, :close_rate, :sd_N, :Algorithm,
                          :model, :room, :connection,
                          'pds_syslist.SystemID', 'pds_syslist.System',
                          'pds_section_assembler.section_N', 'pds_section_assembler.section_name',
                          'psa_ed_powers_pds_valves.section_N', 'psa_ed_powers_pds_valves.section_name',
                          'psa_anc_powers_pds_valves.section_N', 'psa_anc_powers_pds_valves.section_name')

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
      e1['sd_N']             = e[10]
      e1['Algorithm']        = e[11]
      e1['model']            = e[12]
      e1['room']             = e[13]
      e1['connection']       = e[14]
      e1['system']           = { id: e[15], System: e[16] }
      e1['psa_ctrl_power']   = { id: e[17], section_name: e[18] }
      e1['psa_ed_power']     = { id: e[19], section_name: e[20] }
      e1['psa_anc_power']    = { id: e[21], section_name: e[22] }

      e = e1
    end
                        
  end

  def pds_volumes
    @data_list = PdsVolume.where(Project: project.ProjectID)
                          .includes(:system, :pds_man_equip, :pds_sd)
  end

  helper_method :table_header

  Oj.default_options = { mode: :compat }
  def table_header
    Oj.dump(model_class.attribute_names.map { |attr| { property: attr, header: attr } })
  end
end
