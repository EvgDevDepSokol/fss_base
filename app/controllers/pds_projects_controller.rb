# frozen_string_literal: true

class PdsProjectsController < ApplicationController
  include GeneralControllerHelper
  # Project controller
  before_action :set_pds_project, only: %i[show edit update destroy]
  # GET /pds_projects
  # GET /pds_projects.json
  def select
    @pds_projects = PdsProject.includes(:company).where('ProjectID in (?)', PROJECT_LIST)
  end

  # GET /pds_projects/1
  # GET /pds_projects/1.json
  def show
    @project = @pds_project
  end

  # GET /pds_projects/new
  def new
    @pds_project = PdsProject.new
  end

  # POST /pds_projects
  # POST /pds_projects.json
  def create
    @pds_project = PdsProject.new(pds_project_params)

    respond_to do |format|
      if @pds_project.save
        format.html { redirect_to @pds_project, notice: 'Pds project was successfully created.' }
        format.json { render :show, status: :created, location: @pds_project }
      else
        format.html { render :new }
        format.json { render json: @pds_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_projects/1
  # PATCH/PUT /pds_projects/1.json
  def update
    respond_to do |format|
      if @pds_project.update(pds_project_params)
        format.html { redirect_to @pds_project, notice: 'Pds project was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_project }
      else
        format.html { render :edit }
        format.json { render json: @pds_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_projects/1
  # DELETE /pds_projects/1.json
  def destroy
    @pds_project.destroy
    respond_to do |format|
      format.html { redirect_to pds_projects_url, notice: 'Pds project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_pds_project
    @pds_project = PdsProject.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pds_project_params
    params.require(:pds_project).permit(:project_number, :project_name, :project_name_EN, :Contractor, :companyID, :contract_number, :contract_date, :ProjectManager, :SWManager, :HWManager, :Factor, :Description, :Description_EN, :Notes, :BlobObj, :t, :contract_end_date)
  end
end
