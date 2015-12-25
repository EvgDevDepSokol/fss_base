class PdsMetersDigitalsController < ApplicationController
  before_action :set_pds_meters_digital, only: [:show, :edit, :update, :destroy]

  # GET /pds_meters_digitals
  # GET /pds_meters_digitals.json
  def index
    @pds_meters_digitals = PdsMetersDigital.all
  end

  # GET /pds_meters_digitals/1
  # GET /pds_meters_digitals/1.json
  def show
  end

  # GET /pds_meters_digitals/new
  def new
    @pds_meters_digital = PdsMetersDigital.new
  end

  # GET /pds_meters_digitals/1/edit
  def edit
  end

  # POST /pds_meters_digitals
  # POST /pds_meters_digitals.json
  def create
    @pds_meters_digital = PdsMetersDigital.new(pds_meters_digital_params)

    respond_to do |format|
      if @pds_meters_digital.save
        format.html { redirect_to @pds_meters_digital, notice: 'Pds meters digital was successfully created.' }
        format.json { render :show, status: :created, location: @pds_meters_digital }
      else
        format.html { render :new }
        format.json { render json: @pds_meters_digital.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_meters_digitals/1
  # PATCH/PUT /pds_meters_digitals/1.json
  def update
    respond_to do |format|
      if @pds_meters_digital.update(pds_meters_digital_params)
        format.html { redirect_to @pds_meters_digital, notice: 'Pds meters digital was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_meters_digital }
      else
        format.html { render :edit }
        format.json { render json: @pds_meters_digital.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_meters_digitals/1
  # DELETE /pds_meters_digitals/1.json
  def destroy
    @pds_meters_digital.destroy
    respond_to do |format|
      format.html { redirect_to pds_meters_digitals_url, notice: 'Pds meters digital was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_meters_digital
      @pds_meters_digital = PdsMetersDigital.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_meters_digital_params
      params.require(:pds_meters_digital).permit(:IC, :sys, :Project, :ctrl_power, :t)
    end
end
