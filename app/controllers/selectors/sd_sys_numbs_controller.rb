class Selectors::SdSysNumbsController < ApplicationController
  before_action :project, only: :index

  # GET /sd_sys_numbs
  # GET /sd_sys_numbs.json
  def index
    @sd_sys_numbs = SdSysNumb.where(Project: project.ProjectID).order(:sd_link)
    respond_to do |format|
        format.json { render json: Oj.dump(@sd_sys_numbs.map(&:serializable_hash))}
    end    
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  private
  def project
    @project ||= PdsProject.find_by(ProjectID: params[:pds_project_id])
  end
end
