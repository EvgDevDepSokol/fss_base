class PdsMetersController < ApplicationController
  before_action :set_pds_meter, only: [:show, :edit, :update, :destroy]

  # GET /pds_meters
  # GET /pds_meters.json
  def index
    @pds_meters = PdsMeter.all
  end

  # GET /pds_meters/1
  # GET /pds_meters/1.json
  def show
  end

  # GET /pds_meters/new
  def new
    @pds_meter = PdsMeter.new
  end

  # GET /pds_meters/1/edit
  def edit
  end

  # POST /pds_meters
  # POST /pds_meters.json
  def create
    @pds_meter = PdsMeter.new(pds_meter_params)

    respond_to do |format|
      if @pds_meter.save
        format.html { redirect_to @pds_meter, notice: 'Pds meter was successfully created.' }
        format.json { render :show, status: :created, location: @pds_meter }
      else
        format.html { render :new }
        format.json { render json: @pds_meter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_meters/1
  # PATCH/PUT /pds_meters/1.json
  def update
    respond_to do |format|
      if @pds_meter.update(pds_meter_params)
        format.html { redirect_to @pds_meter, notice: 'Pds meter was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_meter }
      else
        format.html { render :edit }
        format.json { render json: @pds_meter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_meters/1
  # DELETE /pds_meters/1.json
  def destroy
    @pds_meter.destroy
    respond_to do |format|
      format.html { redirect_to pds_meters_url, notice: 'Pds meter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_meter
      @pds_meter = PdsMeter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_meter_params
      params.require(:pds_meter).permit(:IC, :sys, :Project, :ctrl_power, :t)
    end
end
