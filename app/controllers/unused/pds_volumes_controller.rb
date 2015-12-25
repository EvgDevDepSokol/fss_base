class PdsVolumesController < ApplicationController
  before_action :set_pds_volume, only: [:show, :edit, :update, :destroy]

  # GET /pds_volumes
  # GET /pds_volumes.json
  def index
    @pds_volumes = PdsVolume.all
  end

  # GET /pds_volumes/1
  # GET /pds_volumes/1.json
  def show
  end

  # GET /pds_volumes/new
  def new
    @pds_volume = PdsVolume.new
  end

  # GET /pds_volumes/1/edit
  def edit
  end

  # POST /pds_volumes
  # POST /pds_volumes.json
  def create
    @pds_volume = PdsVolume.new(pds_volume_params)

    respond_to do |format|
      if @pds_volume.save
        format.html { redirect_to @pds_volume, notice: 'Pds volume was successfully created.' }
        format.json { render :show, status: :created, location: @pds_volume }
      else
        format.html { render :new }
        format.json { render json: @pds_volume.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_volumes/1
  # PATCH/PUT /pds_volumes/1.json
  def update
    respond_to do |format|
      if @pds_volume.update(pds_volume_params)
        format.html { redirect_to @pds_volume, notice: 'Pds volume was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_volume }
      else
        format.html { render :edit }
        format.json { render json: @pds_volume.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_volumes/1
  # DELETE /pds_volumes/1.json
  def destroy
    @pds_volume.destroy
    respond_to do |format|
      format.html { redirect_to pds_volumes_url, notice: 'Pds volume was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_volume
      @pds_volume = PdsVolume.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_volume_params
      params.require(:pds_volume).permit(:kks, :ShortDesc, :Desc_EN, :volume, :height, :level, :room, :Project, :sys, :eq_type, :sd_N)
    end
end
