class PdsRvesController < ApplicationController
  before_action :set_pds_rf, only: [:show, :edit, :update, :destroy]

  # GET /pds_rves
  # GET /pds_rves.json
  def index
    @pds_rves = PdsRf.all
  end

  # GET /pds_rves/1
  # GET /pds_rves/1.json
  def show
  end

  # GET /pds_rves/new
  def new
    @pds_rf = PdsRf.new
  end

  # GET /pds_rves/1/edit
  def edit
  end

  # POST /pds_rves
  # POST /pds_rves.json
  def create
    @pds_rf = PdsRf.new(pds_rf_params)

    respond_to do |format|
      if @pds_rf.save
        format.html { redirect_to @pds_rf, notice: 'Pds rf was successfully created.' }
        format.json { render :show, status: :created, location: @pds_rf }
      else
        format.html { render :new }
        format.json { render json: @pds_rf.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_rves/1
  # PATCH/PUT /pds_rves/1.json
  def update
    respond_to do |format|
      if @pds_rf.update(pds_rf_params)
        format.html { redirect_to @pds_rf, notice: 'Pds rf was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_rf }
      else
        format.html { render :edit }
        format.json { render json: @pds_rf.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_rves/1
  # DELETE /pds_rves/1.json
  def destroy
    @pds_rf.destroy
    respond_to do |format|
      format.html { redirect_to pds_rves_url, notice: 'Pds rf was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_rf
      @pds_rf = PdsRf.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_rf_params
      params.require(:pds_rf).permit(:sys, :Project, :name_RU, :name, :tag_RU, :Desc, :Desc_EN, :range, :Unit, :type, :Type_FB, :unit_FB, :range_FB, :rate, :Ptag, :sd_N, :t, :typerf, :scale, :frfID)
    end
end
