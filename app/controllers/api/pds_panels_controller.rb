class Api::PdsPanelsController < ApplicationController
  before_action :set_pds_panel, only: %i[show edit update destroy]
  before_action :project, only: :index

  # GET /pds_panels
  # GET /pds_panels.json
  def index
    @pds_panels = PdsPanel.where(Project: project.ProjectID).order(:panel)
  end

  # GET /pds_panels/1
  # GET /pds_panels/1.json
  def show; end

  # GET /pds_panels/new
  def new
    @pds_panel = PdsPanel.new
  end

  # GET /pds_panels/1/edit
  def edit; end

  # POST /pds_panels
  # POST /pds_panels.json
  def create
    @pds_panel = PdsPanel.new(pds_panel_params)

    respond_to do |format|
      if @pds_panel.save
        format.html { redirect_to @pds_panel, notice: 'Pds panel was successfully created.' }
        format.json { render :show, status: :created, location: @pds_panel }
      else
        format.html { render :new }
        format.json { render json: @pds_panel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_panels/1
  # PATCH/PUT /pds_panels/1.json
  def update
    respond_to do |format|
      if @pds_panel.update(pds_panel_params)
        format.html { redirect_to @pds_panel, notice: 'Pds panel was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_panel }
      else
        format.html { render :edit }
        format.json { render json: @pds_panel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_panels/1
  # DELETE /pds_panels/1.json
  def destroy
    @pds_panel.destroy
    respond_to do |format|
      format.html { redirect_to pds_panels_url, notice: 'Pds panel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_pds_panel
    @pds_panel = PdsPanel.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pds_panel_params
    params.require(:pds_panel).permit(:panel, :start, :end, :migsjem, :memsjem, :lamptest, :soundtest, :soundtest_warn, :pressconfirm, :soundtest_alarm, :Project, :soundsjem, :soundalarm, :power_lamp, :Tab_No, :pnl_type, :fhd, :lamptest_suff)
  end

  def project
    @project ||= PdsProject.find_by(ProjectID: params[:pds_project_id])
  end
end
