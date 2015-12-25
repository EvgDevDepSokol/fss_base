class PdsLampsController < ApplicationController
  before_action :set_pds_lamp, only: [:show, :edit, :update, :destroy]

  # GET /pds_lamps
  # GET /pds_lamps.json
  def index
    @pds_lamps = PdsLamp.all
  end

  # GET /pds_lamps/1
  # GET /pds_lamps/1.json
  def show
  end

  # GET /pds_lamps/new
  def new
    @pds_lamp = PdsLamp.new
  end

  # GET /pds_lamps/1/edit
  def edit
  end

  # POST /pds_lamps
  # POST /pds_lamps.json
  def create
    @pds_lamp = PdsLamp.new(pds_lamp_params)

    respond_to do |format|
      if @pds_lamp.save
        format.html { redirect_to @pds_lamp, notice: 'Pds lamp was successfully created.' }
        format.json { render :show, status: :created, location: @pds_lamp }
      else
        format.html { render :new }
        format.json { render json: @pds_lamp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_lamps/1
  # PATCH/PUT /pds_lamps/1.json
  def update
    respond_to do |format|
      if @pds_lamp.update(pds_lamp_params)
        format.html { redirect_to @pds_lamp, notice: 'Pds lamp was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_lamp }
      else
        format.html { render :edit }
        format.json { render json: @pds_lamp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_lamps/1
  # DELETE /pds_lamps/1.json
  def destroy
    @pds_lamp.destroy
    respond_to do |format|
      format.html { redirect_to pds_lamps_url, notice: 'Pds lamp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_lamp
      @pds_lamp = PdsLamp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_lamp_params
      params.require(:pds_lamp).permit(:IC, :sys, :Project, :ctrl_power, :t)
    end
end
