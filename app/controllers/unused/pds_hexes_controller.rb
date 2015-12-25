class PdsHexesController < ApplicationController
  before_action :set_pds_hex, only: [:show, :edit, :update, :destroy]

  # GET /pds_hexes
  # GET /pds_hexes.json
  def index
    @pds_hexes = PdsHex.all
  end

  # GET /pds_hexes/1
  # GET /pds_hexes/1.json
  def show
  end

  # GET /pds_hexes/new
  def new
    @pds_hex = PdsHex.new
  end

  # GET /pds_hexes/1/edit
  def edit
  end

  # POST /pds_hexes
  # POST /pds_hexes.json
  def create
    @pds_hex = PdsHex.new(pds_hex_params)

    respond_to do |format|
      if @pds_hex.save
        format.html { redirect_to @pds_hex, notice: 'Pds hex was successfully created.' }
        format.json { render :show, status: :created, location: @pds_hex }
      else
        format.html { render :new }
        format.json { render json: @pds_hex.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_hexes/1
  # PATCH/PUT /pds_hexes/1.json
  def update
    respond_to do |format|
      if @pds_hex.update(pds_hex_params)
        format.html { redirect_to @pds_hex, notice: 'Pds hex was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_hex }
      else
        format.html { render :edit }
        format.json { render json: @pds_hex.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_hexes/1
  # DELETE /pds_hexes/1.json
  def destroy
    @pds_hex.destroy
    respond_to do |format|
      format.html { redirect_to pds_hexes_url, notice: 'Pds hex was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_hex
      @pds_hex = PdsHex.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_hex_params
      params.require(:pds_hex).permit(:kks, :ShortDesc, :s, :level, :room, :Project, :sys, :eq_type, :var, :old_var, :Desc_EN, :sd_N)
    end
end
