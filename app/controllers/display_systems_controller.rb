class DisplaySystemsController < BaseController
  # Controller for display systems
  ACTIONS = %i[pds_ppca pds_ppcd pds_sd].freeze

  def pds_ppcas
    @data_list = PdsPpca
                 .where(Project: project.ProjectID)
                 .includes(:system, :pds_detector)
                 .plucked
  end

  def pds_ppcds
    @data_list = PdsPpcd
                 .where(Project: project.ProjectID)
                 .includes(:system, :pds_detector)
                 .plucked
  end

  def pds_sds
    @data_list = PdsSd
                 .where(Project: project.ProjectID)
                 .includes(:system)
                 .order(:sys, :Numb)
                 .plucked
  end

  helper_method :table_header

  def table_header
    model_class.attribute_names.map { |attr| { property: attr, header: attr } }.to_json
  end
end
