# Discrepancy reports
class PdsDrsController < BaseController
  layout nil # resets layouts/table
  # layout 'pds_drs' # resets layouts/table
  ACTIONS = %i[pds_drs pds_dr_comments].freeze

  def pds_drs
    # @data_list = PdsDr.where(Project: project.ProjectID)
    #                   .includes(:system, :pds_engineer_author, :pds_engineer_reply, :pds_engineer_closed).plucked(project.ProjectID)
    @data_list = PdsDr.where(Project: project.ProjectID)
                      .includes(:system, :pds_engineer_author).plucked(project.ProjectID)

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

  def create_dr_and_comment
    if params[:is_new]
      pds_dr = PdsDr.new params[:pds_dr].permit!
    else
      pds_dr_u = params[:pds_dr]
      pds_dr = PdsDr.find(pds_dr_u[:id])
      pds_dr.sys = pds_dr_u[:sys]
      pds_dr.Priority = pds_dr_u[:Priority]
    end
    pds_dr.save
    pds_dr_comment = PdsDrComment.new params[:pds_dr_comment].permit!
    pds_dr_comment.pds_dr_id = pds_dr.id
    pds_dr_comment.save
    data = PdsDr.where(id: pds_dr.id)
                .includes(:system, :pds_engineer_author, :pds_engineer_reply, :pds_engineer_closed)
                .plucked(pds_dr.Project)
    render json: { status: :created, data: data }
  end
end
