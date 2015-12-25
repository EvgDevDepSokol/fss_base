class PdsMetersChannelsController < ApplicationController
  before_action :set_pds_meters_channel, only: [:show, :edit, :update, :destroy]

  # GET /pds_meters_channels
  # GET /pds_meters_channels.json
  def index
    @pds_meters_channels = PdsMetersChannel.all
  end

  # GET /pds_meters_channels/1
  # GET /pds_meters_channels/1.json
  def show
  end

  # GET /pds_meters_channels/new
  def new
    @pds_meters_channel = PdsMetersChannel.new
  end

  # GET /pds_meters_channels/1/edit
  def edit
  end

  # POST /pds_meters_channels
  # POST /pds_meters_channels.json
  def create
    @pds_meters_channel = PdsMetersChannel.new(pds_meters_channel_params)

    respond_to do |format|
      if @pds_meters_channel.save
        format.html { redirect_to @pds_meters_channel, notice: 'Pds meters channel was successfully created.' }
        format.json { render :show, status: :created, location: @pds_meters_channel }
      else
        format.html { render :new }
        format.json { render json: @pds_meters_channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_meters_channels/1
  # PATCH/PUT /pds_meters_channels/1.json
  def update
    respond_to do |format|
      if @pds_meters_channel.update(pds_meters_channel_params)
        format.html { redirect_to @pds_meters_channel, notice: 'Pds meters channel was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_meters_channel }
      else
        format.html { render :edit }
        format.json { render json: @pds_meters_channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_meters_channels/1
  # DELETE /pds_meters_channels/1.json
  def destroy
    @pds_meters_channel.destroy
    respond_to do |format|
      format.html { redirect_to pds_meters_channels_url, notice: 'Pds meters channel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_meters_channel
      @pds_meters_channel = PdsMetersChannel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_meters_channel_params
      params.require(:pds_meters_channel).permit(:IC, :sys, :Project, :ctrl_power, :t)
    end
end
