class PdsButtonsLightsController < ApplicationController
  before_action :set_pds_buttons_light, only: [:show, :edit, :update, :destroy]

  # GET /pds_buttons_lights
  # GET /pds_buttons_lights.json
  def index
    @pds_buttons_lights = PdsButtonsLight.all
  end

  # GET /pds_buttons_lights/1
  # GET /pds_buttons_lights/1.json
  def show
  end

  # GET /pds_buttons_lights/new
  def new
    @pds_buttons_light = PdsButtonsLight.new
  end

  # GET /pds_buttons_lights/1/edit
  def edit
  end

  # POST /pds_buttons_lights
  # POST /pds_buttons_lights.json
  def create
    @pds_buttons_light = PdsButtonsLight.new(pds_buttons_light_params)

    respond_to do |format|
      if @pds_buttons_light.save
        format.html { redirect_to @pds_buttons_light, notice: 'Pds buttons light was successfully created.' }
        format.json { render :show, status: :created, location: @pds_buttons_light }
      else
        format.html { render :new }
        format.json { render json: @pds_buttons_light.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_buttons_lights/1
  # PATCH/PUT /pds_buttons_lights/1.json
  def update
    respond_to do |format|
      if @pds_buttons_light.update(pds_buttons_light_params)
        format.html { redirect_to @pds_buttons_light, notice: 'Pds buttons light was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_buttons_light }
      else
        format.html { render :edit }
        format.json { render json: @pds_buttons_light.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_buttons_lights/1
  # DELETE /pds_buttons_lights/1.json
  def destroy
    @pds_buttons_light.destroy
    respond_to do |format|
      format.html { redirect_to pds_buttons_lights_url, notice: 'Pds buttons light was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_buttons_light
      @pds_buttons_light = PdsButtonsLight.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_buttons_light_params
      params.require(:pds_buttons_light).permit(:IC, :sys, :Project, :ctrl_power, :range, :Fixed, :t)
    end
end
