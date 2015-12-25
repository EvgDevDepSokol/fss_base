class PdsEquipsController < ApplicationController
  before_action :set_pds_equip, only: [:show, :edit, :update, :destroy]

  # GET /pds_equips
  # GET /pds_equips.json
  def index
    Rails.logger.info params
    @grid = initialize_grid(model)
    render 'shared/index'
    #@pds_equips = PdsEquip.all
  end

  # GET /pds_equips/1
  # GET /pds_equips/1.json
  def show
  end

  # GET /pds_equips/new
  def new
    @pds_equip = PdsEquip.new
  end

  # GET /pds_equips/1/edit
  def edit
  end

  # POST /pds_equips
  # POST /pds_equips.json
  def create
    @pds_equip = PdsEquip.new(pds_equip_params)

    respond_to do |format|
      if @pds_equip.save
        format.html { redirect_to @pds_equip, notice: 'Pds equip was successfully created.' }
        format.json { render :show, status: :created, location: @pds_equip }
      else
        format.html { render :new }
        format.json { render json: @pds_equip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_equips/1
  # PATCH/PUT /pds_equips/1.json
  def update
    respond_to do |format|
      if @pds_equip.update(pds_equip_params)
        format.html { redirect_to @pds_equip, notice: 'Pds equip was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_equip }
      else
        format.html { render :edit }
        format.json { render json: @pds_equip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_equips/1
  # DELETE /pds_equips/1.json
  def destroy
    @pds_equip.destroy
    respond_to do |format|
      format.html { redirect_to pds_equips_url, notice: 'Pds equip was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_equip
      @pds_equip = PdsEquip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_equip_params
      params.require(:pds_equip).permit(:typeE)
    end
end
