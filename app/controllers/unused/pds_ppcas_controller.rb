class PdsPpcasController < ApplicationController
  before_action :set_pds_ppca, only: [:show, :edit, :update, :destroy]

  # GET /pds_ppcas
  # GET /pds_ppcas.json
  def index
    @pds_ppcas = PdsPpca.all
  end

  # GET /pds_ppcas/1
  # GET /pds_ppcas/1.json
  def show
  end

  # GET /pds_ppcas/new
  def new
    @pds_ppca = PdsPpca.new
  end

  # GET /pds_ppcas/1/edit
  def edit
  end

  # POST /pds_ppcas
  # POST /pds_ppcas.json
  def create
    @pds_ppca = PdsPpca.new(pds_ppca_params)

    respond_to do |format|
      if @pds_ppca.save
        format.html { redirect_to @pds_ppca, notice: 'Pds ppca was successfully created.' }
        format.json { render :show, status: :created, location: @pds_ppca }
      else
        format.html { render :new }
        format.json { render json: @pds_ppca.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_ppcas/1
  # PATCH/PUT /pds_ppcas/1.json
  def update
    respond_to do |format|
      if @pds_ppca.update(pds_ppca_params)
        format.html { redirect_to @pds_ppca, notice: 'Pds ppca was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_ppca }
      else
        format.html { render :edit }
        format.json { render json: @pds_ppca.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_ppcas/1
  # DELETE /pds_ppcas/1.json
  def destroy
    @pds_ppca.destroy
    respond_to do |format|
      format.html { redirect_to pds_ppcas_url, notice: 'Pds ppca was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_ppca
      @pds_ppca = PdsPpca.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_ppca_params
      params.require(:pds_ppca).permit(:Project, :sys, :Shifr, :Key, :identif, :Description, :Description_EN, :Detector, :Unit, :L_lim, :U_lim, :nom, :LA, :LW, :HW, :HA, :t, :code, :power, :UnitID)
    end
end
