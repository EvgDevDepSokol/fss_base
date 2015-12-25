class PdsUnitsController < ApplicationController
  before_action :set_pds_unit, only: [:show, :edit, :update, :destroy]

  # GET /pds_units
  # GET /pds_units.json
  def index
    @pds_units = PdsUnit.all
  end

  # GET /pds_units/1
  # GET /pds_units/1.json
  def show
  end

  # GET /pds_units/new
  def new
    @pds_unit = PdsUnit.new
  end

  # GET /pds_units/1/edit
  def edit
  end

  # POST /pds_units
  # POST /pds_units.json
  def create
    @pds_unit = PdsUnit.new(pds_unit_params)

    respond_to do |format|
      if @pds_unit.save
        format.html { redirect_to @pds_unit, notice: 'Pds unit was successfully created.' }
        format.json { render :show, status: :created, location: @pds_unit }
      else
        format.html { render :new }
        format.json { render json: @pds_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_units/1
  # PATCH/PUT /pds_units/1.json
  def update
    respond_to do |format|
      if @pds_unit.update(pds_unit_params)
        format.html { redirect_to @pds_unit, notice: 'Pds unit was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_unit }
      else
        format.html { render :edit }
        format.json { render json: @pds_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_units/1
  # DELETE /pds_units/1.json
  def destroy
    @pds_unit.destroy
    respond_to do |format|
      format.html { redirect_to pds_units_url, notice: 'Pds unit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_unit
      @pds_unit = PdsUnit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_unit_params
      params.require(:pds_unit).permit(:Unit_RU, :Unit_EN, :MultFactor, :ZeroShift, :t, :import_t)
    end
end
