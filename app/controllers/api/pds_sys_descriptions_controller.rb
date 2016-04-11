class Api::PdsSysDescriptionsController < ApplicationController
  before_action :set_pds_sys_description, only: [:show, :edit, :update, :destroy]
  before_action :project, only: :index

  # GET /pds_sys_descriptions
  # GET /pds_sys_descriptions.json
  def index
    @pds_sys_descriptions = PdsSysDescription.where(Project: project.ProjectID).select(:SysID, :Project, :sys)
  end

  # GET /pds_sys_descriptions/1
  # GET /pds_sys_descriptions/1.json
  def show
  end

  # GET /pds_sys_descriptions/new
  def new
    @pds_sys_description = PdsSysDescription.new
  end

  # GET /pds_sys_descriptions/1/edit
  def edit
  end

  # POST /pds_sys_descriptions
  # POST /pds_sys_descriptions.json
  def create
    @pds_sys_description = PdsSysDescription.new(pds_sys_description_params)

    respond_to do |format|
      if @pds_sys_description.save
        format.html { redirect_to @pds_sys_description, notice: 'Pds sys description was successfully created.' }
        format.json { render :show, status: :created, location: @pds_sys_description }
      else
        format.html { render :new }
        format.json { render json: @pds_sys_description.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_sys_descriptions/1
  # PATCH/PUT /pds_sys_descriptions/1.json
  def update
    respond_to do |format|
      if @pds_sys_description.update(pds_sys_description_params)
        format.html { redirect_to @pds_sys_description, notice: 'Pds sys description was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_sys_description }
      else
        format.html { render :edit }
        format.json { render json: @pds_sys_description.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_sys_descriptions/1
  # DELETE /pds_sys_descriptions/1.json
  def destroy
    @pds_sys_description.destroy
    respond_to do |format|
      format.html { redirect_to pds_sys_descriptions_url, notice: 'Pds sys description was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_sys_description
      @pds_sys_description = PdsSysDescription.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_sys_description_params
      params.require(:pds_sys_description).permit(:Project, :sys, :Description, :Description_EN, :shortDesc, :shortDesc_EN)
    end

    def project
      @project ||= PdsProject.find_by(ProjectID: params[:pds_project_id])
    end   
end
