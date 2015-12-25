class PdsRegulatorsController < ApplicationController
  before_action :set_pds_regulator, only: [:show, :edit, :update, :destroy]

  # GET /pds_regulators
  # GET /pds_regulators.json
  def index
    @pds_regulators = PdsRegulator.all
  end

  # GET /pds_regulators/1
  # GET /pds_regulators/1.json
  def show
  end

  # GET /pds_regulators/new
  def new
    @pds_regulator = PdsRegulator.new
  end

  # GET /pds_regulators/1/edit
  def edit
  end

  # POST /pds_regulators
  # POST /pds_regulators.json
  def create
    @pds_regulator = PdsRegulator.new(pds_regulator_params)

    respond_to do |format|
      if @pds_regulator.save
        format.html { redirect_to @pds_regulator, notice: 'Pds regulator was successfully created.' }
        format.json { render :show, status: :created, location: @pds_regulator }
      else
        format.html { render :new }
        format.json { render json: @pds_regulator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_regulators/1
  # PATCH/PUT /pds_regulators/1.json
  def update
    respond_to do |format|
      if @pds_regulator.update(pds_regulator_params)
        format.html { redirect_to @pds_regulator, notice: 'Pds regulator was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_regulator }
      else
        format.html { render :edit }
        format.json { render json: @pds_regulator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_regulators/1
  # DELETE /pds_regulators/1.json
  def destroy
    @pds_regulator.destroy
    respond_to do |format|
      format.html { redirect_to pds_regulators_url, notice: 'Pds regulator was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_regulator
      @pds_regulator = PdsRegulator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_regulator_params
      params.require(:pds_regulator).permit(:model, :Project, :sys, :tag_RU, :tag_EN, :station_sys, :Desc, :ed_power, :ctrl_power, :anc_power, :nom_state, :open_rate, :close_rate, :sd_N, :doc_reg_N, :Algorithm, :t, :Desc_EN, :import_t, :mod, :vlv, :vlv_1, :vlv_2, :det_id, :eq_type, :par_val)
    end
end
