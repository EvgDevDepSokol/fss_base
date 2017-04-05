class Api::PdsManEquipsController < ApplicationController
  before_action :set_pds_man_equip, only: %i[show edit update destroy]

  # GET /pds_man_equips
  # GET /pds_man_equips.json
  def index
    @pds_man_equips = PdsManEquip.all.order(:Type)
  end

  # GET /pds_man_equips/1
  # GET /pds_man_equips/1.json
  def show; end

  # GET /pds_man_equips/new
  def new
    @pds_man_equip = PdsManEquip.new
  end

  # GET /pds_man_equips/1/edit
  def edit; end

  # POST /pds_man_equips
  # POST /pds_man_equips.json
  def create
    @pds_man_equip = PdsManEquip.new(pds_man_equip_params)

    respond_to do |format|
      if @pds_man_equip.save
        format.html { redirect_to @pds_man_equip, notice: 'Pds man equip was successfully created.' }
        format.json { render :show, status: :created, location: @pds_man_equip }
      else
        format.html { render :new }
        format.json { render json: @pds_man_equip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_man_equips/1
  # PATCH/PUT /pds_man_equips/1.json
  def update
    respond_to do |format|
      if @pds_man_equip.update(pds_man_equip_params)
        format.html { redirect_to @pds_man_equip, notice: 'Pds man equip was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_man_equip }
      else
        format.html { render :edit }
        format.json { render json: @pds_man_equip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_man_equips/1
  # DELETE /pds_man_equips/1.json
  def destroy
    @pds_man_equip.destroy
    respond_to do |format|
      format.html { redirect_to pds_man_equips_url, notice: 'Pds man equip was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_pds_man_equip
    @pds_man_equip = PdsManEquip.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pds_man_equip_params
    params.require(:pds_man_equip).permit(:Type, :Descriptor, :Contr_win, :Over_menu, :Comp_malf, :t)
  end
end
