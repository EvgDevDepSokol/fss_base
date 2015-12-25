class PdsMnemosController < ApplicationController
  before_action :set_pds_mnemo, only: [:show, :edit, :update, :destroy]

  # GET /pds_mnemos
  # GET /pds_mnemos.json
  def index
    @pds_mnemos = PdsMnemo.all
  end

  # GET /pds_mnemos/1
  # GET /pds_mnemos/1.json
  def show
  end

  # GET /pds_mnemos/new
  def new
    @pds_mnemo = PdsMnemo.new
  end

  # GET /pds_mnemos/1/edit
  def edit
  end

  # POST /pds_mnemos
  # POST /pds_mnemos.json
  def create
    @pds_mnemo = PdsMnemo.new(pds_mnemo_params)

    respond_to do |format|
      if @pds_mnemo.save
        format.html { redirect_to @pds_mnemo, notice: 'Pds mnemo was successfully created.' }
        format.json { render :show, status: :created, location: @pds_mnemo }
      else
        format.html { render :new }
        format.json { render json: @pds_mnemo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_mnemos/1
  # PATCH/PUT /pds_mnemos/1.json
  def update
    respond_to do |format|
      if @pds_mnemo.update(pds_mnemo_params)
        format.html { redirect_to @pds_mnemo, notice: 'Pds mnemo was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_mnemo }
      else
        format.html { render :edit }
        format.json { render json: @pds_mnemo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_mnemos/1
  # DELETE /pds_mnemos/1.json
  def destroy
    @pds_mnemo.destroy
    respond_to do |format|
      format.html { redirect_to pds_mnemos_url, notice: 'Pds mnemo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_mnemo
      @pds_mnemo = PdsMnemo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_mnemo_params
      params.require(:pds_mnemo).permit(:sys, :Project, :Code, :Marker, :TechCode, :Type, :Opened, :Closed, :Control, :AutoDist, :Parameter, :Description, :Description_EN, :Gr_Dreg, :Detector, :Characteristics)
    end
end
