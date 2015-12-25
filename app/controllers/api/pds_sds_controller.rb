class Api::PdsSdsController < ApplicationController
  before_action :set_pds_sd, only: [:show, :edit, :update, :destroy]

  # GET /pds_sds
  # GET /pds_sds.json
  def index
    @pds_sds = PdsSd.all
  end

  # GET /pds_sds/1
  # GET /pds_sds/1.json
  def show
  end

  # GET /pds_sds/new
  def new
    @pds_sd = PdsSd.new
  end

  # GET /pds_sds/1/edit
  def edit
  end

  # POST /pds_sds
  # POST /pds_sds.json
  def create
    SdTitle
    respond_to do |format|
      if @pds_sd.save
        format.html { redirect_to @pds_sd, notice: 'Pds sd was successfully created.' }
        format.json { render :show, status: :created, location: @pds_sd }
      else
        format.html { render :new }
        format.json { render json: @pds_sd.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_sds/1
  # PATCH/PUT /pds_sds/1.json
  def update
    respond_to do |format|
      if @pds_sd.update(pds_sd_params)
        format.html { redirect_to @pds_sd, notice: 'Pds sd was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_sd }
      else
        format.html { render :edit }
        format.json { render json: @pds_sd.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_sds/1
  # DELETE /pds_sds/1.json
  def destroy
    @pds_sd.destroy
    respond_to do |format|
      format.html { redirect_to pds_sds_url, notice: 'Pds sd was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_sd
      @pds_sd = PdsSd.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_sd_params
      params.require(:pds_sd).permit(:SdTitle, :sys, :Project, :title_EN, :Numb, :BlobObj, :t, :from_sapfir)
    end
end
