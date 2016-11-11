class Api::PdsProjectUnitsController < ApplicationController
  before_action :set_pds_project_unit, only: [:show, :edit, :update, :destroy]
  before_action :project, only: :index
  # GET /pds_project_units
  # GET /pds_project_units.json
  def index
    @pds_project_units = PdsProjectUnit.where(Project: project.ProjectID).includes(:unit)
                  .order('pds_unit.Unit_RU')
    # @tmp = @pds_project_units.map{ |e| e.custom_hash }
    # render json: {status: :ok , data:  @tmp}
  end

  # GET /pds_project_units/1
  # GET /pds_project_units/1.json
  def show
  end

  # GET /pds_project_units/new
  def new
    @pds_project_unit = PdsProjectUnit.new
  end

  # GET /pds_project_units/1/edit
  def edit
  end

  # POST /pds_project_units
  # POST /pds_project_units.json
  def create
    @pds_project_unit = PdsProjectUnit.new(pds_project_unit_params)

    respond_to do |format|
      if @pds_project_unit.save
        format.html { redirect_to @pds_project_unit, notice: 'Pds project unit was successfully created.' }
        format.json { render :show, status: :created, location: @pds_project_unit }
      else
        format.html { render :new }
        format.json { render json: @pds_project_unit.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_project_units/1
  # PATCH/PUT /pds_project_units/1.json
  def update
    respond_to do |format|
      if @pds_project_unit.update(pds_project_unit_params)
        format.html { redirect_to @pds_project_unit, notice: 'Pds project unit was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_project_unit }
      else
        format.html { render :edit }
        format.json { render json: @pds_project_unit.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_project_units/1
  # DELETE /pds_project_units/1.json
  def destroy
    @pds_project_unit.destroy
    respond_to do |format|
      format.html { redirect_to pds_project_units_url, notice: 'Pds project unit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_pds_project_unit
    @pds_project_unit = PdsProjectUnit.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pds_project_unit_params
    params.require(:pds_project_unit).permit(:Project, :Unit, :t)
  end

  def project
    @project ||= PdsProject.find_by(ProjectID: params[:pds_project_id])
  end
end
