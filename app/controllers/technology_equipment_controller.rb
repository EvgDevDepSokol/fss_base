class TechnologyEquipmentController < BaseController

  ACTIONS = [ :pds_detectors, :pds_motors, :pds_valves, :pds_regulators,
    :pds_ejector, :pds_hex, :pds_volume, :pds_filter, :pds_motor_type,
    :pds_man_equip, :pds_alg_type ]

  def pds_alg_types
    @data_list = PdsAlgType.where(Project: project.ProjectID)
  end

  def pds_detectors
    @data_list = PdsDetector.where(Project: project.ProjectID).select(
      :DetID, :Project, :sys, :station_sys, :tag, :tag_RU, :Desc, :Desc_EN,
      :ctrl_power, :low_lim, :up_lim, :LA, :HA, :LW, 
      :HW, :LT, :HT, :Unit, :'1coef_shift', :'2coef_scale', 
      :sd_N, :doc_reg_N, :t, :Type, :TypeDetec, :Room, :SCK_input, 
      :power, 
      :import_t, :mod, :eq_type). 
      includes(:system, :pds_section_assembler,
               :pds_man_equip, :pds_sd, pds_project_unit: [:unit]) 
      # @data_list = PdsDetector.where(Project: project.ProjectID).select(
      #   :DetID, :Project, :sys, :station_sys, :tag, :tag_RU, :Desc, :Desc_EN,
      #   :Group_N, :ctrl_power, :nom_state, :low_lim, :up_lim, :LA, :HA, :LW, 
      #   :HW, :LT, :HT, :Unit, :'1coef_shift', :'2coef_scale', :sluggishness,
      #   :scale_noise,
      #   :sd_N, :doc_reg_N, :Func, :t, :Type, :TypeDetec, :Room, :SPTable, :SCK_input, 
      #   :SP_1, :SP_2, :SP_3, :SPT_ACTION, :SPT_COMMENT, :DREG_input, :TimeConst, :power, 
      #   :varible, :import_t, :mod, :eq_type, :alg_type). 
      #   includes(:system, :pds_section_assembler,
      #   :pds_man_equip, :pds_sd, pds_project_unit: [:unit])  
  end

  def pds_ejectors
    @data_list = PdsEjector.where(Project: project.ProjectID).
      includes(:system, :pds_man_equip, :pds_sd).
      includes(pds_project_unit: [:unit])
  end

  def pds_filters
    @data_list = PdsFilter.where(Project: project.ProjectID).
      includes(:system, :pds_man_equip, :pds_sd)
  end

  # todo: проверить список возвращающихся значений
  def pds_hexes
    @data_list = PdsHex.where(Project: project.ProjectID).
      includes(:system, :pds_man_equip, :pds_sd).
      includes(pds_project_unit: [:unit])
  end

  def pds_man_equips
    @data_list = PdsManEquip.all.select(:EquipN, :Type, :Descriptor, :Comp_malf)
    #@data_list = PdsManEquip.all
  end

  def pds_motor_types
    @data_list = PdsMotorType.all
  end

  def pds_motors
    @data_list = PdsMotor.where(Project: project.ProjectID).
      includes(:system, :psa_ctrl_power, :psa_ed_power, :psa_anc_power,
:pds_motor_type,
        :pds_man_equip, :pds_sd, :pds_documentation)
  end

  def pds_regulators
    @data_list = PdsRegulator.where(Project: project.ProjectID).
      includes(:system, :psa_ctrl_power, :psa_ed_power, :psa_anc_power,
        :pds_man_equip, :pds_sd, :pds_documentation, :value_1,
        :value_2, :pds_detector)
  end

  def pds_valves
    @data_list = PdsValf.where(Project: project.ProjectID).
      includes(:system, :psa_ctrl_power, :psa_ed_power, :psa_anc_power,
        :pds_man_equip, :pds_sd, :pds_documentation)
  end

  def pds_volumes
    @data_list = PdsVolume.where(Project: project.ProjectID).
      includes(:system, :pds_man_equip, :pds_sd)
  end

  helper_method :table_header

  Oj.default_options = { :mode => :compat }
  def table_header
    Oj.dump(model_class.attribute_names.map{ |attr| {property: attr, header: attr}})
  end

end
