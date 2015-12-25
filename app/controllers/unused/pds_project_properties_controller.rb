class PdsProjectPropertiesController < ApplicationController
  before_action :set_pds_project_property, only: [:show, :edit, :update, :destroy]

  # GET /pds_project_properties
  # GET /pds_project_properties.json
  def index
    @pds_project_properties = PdsProjectProperty.all
  end

  # GET /pds_project_properties/1
  # GET /pds_project_properties/1.json
  def show
  end

  # GET /pds_project_properties/new
  def new
    @pds_project_property = PdsProjectProperty.new
  end

  # GET /pds_project_properties/1/edit
  def edit
  end

  # POST /pds_project_properties
  # POST /pds_project_properties.json
  def create
    @pds_project_property = PdsProjectProperty.new(pds_project_property_params)

    respond_to do |format|
      if @pds_project_property.save
        format.html { redirect_to @pds_project_property, notice: 'Pds project property was successfully created.' }
        format.json { render :show, status: :created, location: @pds_project_property }
      else
        format.html { render :new }
        format.json { render json: @pds_project_property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_project_properties/1
  # PATCH/PUT /pds_project_properties/1.json
  def update
    respond_to do |format|
      if @pds_project_property.update(pds_project_property_params)
        format.html { redirect_to @pds_project_property, notice: 'Pds project property was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_project_property }
      else
        format.html { render :edit }
        format.json { render json: @pds_project_property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_project_properties/1
  # DELETE /pds_project_properties/1.json
  def destroy
    @pds_project_property.destroy
    respond_to do |format|
      format.html { redirect_to pds_project_properties_url, notice: 'Pds project property was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_project_property
      @pds_project_property = PdsProjectProperty.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_project_property_params
      params.require(:pds_project_property).permit(:HostName, :HostIP, :SimDir, :ISName, :ISIP, :RootPass, :IOPass, :LoadPass, :TgisPass, :OSType, :LowLimKeyField, :UpLimKeyField, :Language, :Enabled, :ResName, :ClassLib, :ServicePort, :StatsInterval, :pdsCode, :fdsCode, :portS3serv, :report_prefix, :Encoding, :pmCode, :pmShortCode, :stCode, :stShortCode)
    end
end
