class PdsMalfunctionsController < ApplicationController
  before_action :set_pds_malfunction, only: [:show, :edit, :update, :destroy]

  # GET /pds_malfunctions
  # GET /pds_malfunctions.json
  def index
    @pds_malfunctions = PdsMalfunction.all
  end

  # GET /pds_malfunctions/1
  # GET /pds_malfunctions/1.json
  def show
  end

  # GET /pds_malfunctions/new
  def new
    @pds_malfunction = PdsMalfunction.new
  end

  # GET /pds_malfunctions/1/edit
  def edit
  end

  # POST /pds_malfunctions
  # POST /pds_malfunctions.json
  def create
    @pds_malfunction = PdsMalfunction.new(pds_malfunction_params)

    respond_to do |format|
      if @pds_malfunction.save
        format.html { redirect_to @pds_malfunction, notice: 'Pds malfunction was successfully created.' }
        format.json { render :show, status: :created, location: @pds_malfunction }
      else
        format.html { render :new }
        format.json { render json: @pds_malfunction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_malfunctions/1
  # PATCH/PUT /pds_malfunctions/1.json
  def update
    respond_to do |format|
      if @pds_malfunction.update(pds_malfunction_params)
        format.html { redirect_to @pds_malfunction, notice: 'Pds malfunction was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_malfunction }
      else
        format.html { render :edit }
        format.json { render json: @pds_malfunction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_malfunctions/1
  # DELETE /pds_malfunctions/1.json
  def destroy
    @pds_malfunction.destroy
    respond_to do |format|
      format.html { redirect_to pds_malfunctions_url, notice: 'Pds malfunction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_malfunction
      @pds_malfunction = PdsMalfunction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_malfunction_params
      params.require(:pds_malfunction).permit(:sys, :Dimension, :Project, :Numb, :shortDesc, :shortDesc_EN, :cause, :cause_EN, :fullDesc, :fullDesc_EN, :type, :if_delete, :if_delete_EN, :lowlim_regidity, :uplim_regidity, :regidity_unit, :regidity_text, :regidity_text_EN, :Unit_status, :t, :File, :regidity_unitid, :scale, :sd_N)
    end
end
