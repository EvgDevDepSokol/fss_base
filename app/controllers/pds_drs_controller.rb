# Discrepancy reports
class PdsDrsController < BaseController
  layout nil # resets layouts/table
  # layout 'pds_drs' # resets layouts/table
  ACTIONS = %i[pds_drs pds_dr_comments].freeze

  def pds_drs
    @data_list = PdsDr.where(Project: project.ProjectID)
                      .includes(:system, :pds_engineer_author, :pds_engineer_reply, :pds_engineer_closed).plucked(project.ProjectID)
  end

  helper_method :table_header
  def table_header
    model_class.attribute_names.map { |attr| { property: attr, header: attr } }.to_json
  end
end