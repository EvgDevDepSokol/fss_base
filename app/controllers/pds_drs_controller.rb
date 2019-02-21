# Discrepancy reports
class PdsDrsController < BaseController
  layout nil # resets layouts/table
  # layout 'pds_drs' # resets layouts/table
  ACTIONS = %i[pds_drs pds_dr_comments].freeze

  def pds_drs
    @data_list = PdsDr.where(Project: project.ProjectID)
                      .includes(:system, :pds_engineer_author, :pds_engineer_reply, :pds_engineer_closed).plucked(project.ProjectID)

    @sys_eng_list = {}
    @eng_sys_list = {}
    PdsEngOnSy.where(project: project.ProjectID)
              .includes(:pds_engineer, :system)
              .order('pds_syslist.System')
              .pluck(:sys, 'pds_syslist.System', 'pds_engineers.engineer_N', 'pds_engineers.name')
              .each.map do |e|
      @sys_eng_list[e[0]] = { 'sys_name': e[1], 'engineers': [] } if @sys_eng_list[e[0]].nil?
      @sys_eng_list[e[0]][:engineers].push('eng_id': e[2], 'eng_name': e[3])
      @eng_sys_list[e[2]] = { 'eng_name': e[3], 'systems': [] } if @eng_sys_list[e[2]].nil?
      @eng_sys_list[e[2]][:systems].push('sys_id': e[0], 'sys_name': e[1])
    end
  end

  def create
    @current_object = model_class.new permit_params
    if @current_object.save permit_params
      render json: { status: :created, data: data }
    else
      render json: { errors: @current_object.errors.full_messages }, status: :unprocessable_entity
      Rails.logger.info(@current_object.errors.full_messages)
    end
  end
end
