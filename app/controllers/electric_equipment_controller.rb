class ElectricEquipmentController < BaseController
  ACTIONS = [:pds_breakers, :pds_equipments, :pds_section_assemblers].freeze

  def pds_breakers
    @data_list = PdsBreaker.where(Project: project.ProjectID).
                 # includes(:system, :psa_ctrl_power, :psa_ed_power, :psa_anc_power, :pds_sd)
                 includes(:system, :psa_ctrl_power, :psa_anc_power, :pds_sd)
  end

  def pds_equipments
    @data_list = PdsEquipment.where(Project: project.ProjectID)
                             .includes(:system, :pds_sd, :pds_man_equip)
  end

  def pds_section_assemblers
    @data_list = PdsSectionAssembler.where(Project: project.ProjectID).all
  end

  helper_method :table_header

  def table_header
    model_class.attribute_names.map { |attr| { property: attr, header: attr } }.to_json
  end
end
