class Api::PdsDocumentationsController < ApplicationController
  before_action :set_pds_documentation, only: [:show, :edit, :update, :destroy]
  before_action :project, only: :index

  # GET /pds_documentations
  # GET /pds_documentations.json
  def index
    @pds_documentations = PdsDocumentation.where(Project: project.ProjectID).order(:DocTitle)
  end

  # GET /pds_documentations/1
  # GET /pds_documentations/1.json
  def show
  end

  # GET /pds_documentations/new
  def new
    @pds_documentation = PdsDocumentation.new
  end

  # GET /pds_documentations/1/edit
  def edit
  end

  # POST /pds_documentations
  # POST /pds_documentations.json
  def create
    @pds_documentation = PdsDocumentation.new(pds_documentation_params)

    respond_to do |format|
      if @pds_documentation.save
        format.html { redirect_to @pds_documentation, notice: 'Pds documentation was successfully created.' }
        format.json { render :show, status: :created, location: @pds_documentation }
      else
        format.html { render :new }
        format.json { render json: @pds_documentation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_documentations/1
  # PATCH/PUT /pds_documentations/1.json
  def update
    respond_to do |format|
      if @pds_documentation.update(pds_documentation_params)
        format.html { redirect_to @pds_documentation, notice: 'Pds documentation was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_documentation }
      else
        format.html { render :edit }
        format.json { render json: @pds_documentation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_documentations/1
  # DELETE /pds_documentations/1.json
  def destroy
    @pds_documentation.destroy
    respond_to do |format|
      format.html { redirect_to pds_documentations_url, notice: 'Pds documentation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_pds_documentation
    @pds_documentation = PdsDocumentation.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pds_documentation_params
    params.require(:pds_documentation).permit(:Project, :Type, :NPP_Number, :Revision, :reg_ID, :getting_date, :DocTitle, :DocTitle_EN, :Hardcopy, :File, :t)
  end

  def project
    @project ||= PdsProject.find_by(ProjectID: params[:pds_project_id])
  end
end
