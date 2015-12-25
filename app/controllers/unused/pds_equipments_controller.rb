class PdsEquipmentsController < ApplicationController
  before_action :set_pds_equipment, only: [:show, :edit, :update, :destroy]

  # GET /pds_equipments
  # GET /pds_equipments.json
  def index
    @pds_equipments = PdsEquipment.all
  end

  # GET /pds_equipments/1
  # GET /pds_equipments/1.json
  def show
  end

  # GET /pds_equipments/new
  def new
    @pds_equipment = PdsEquipment.new
  end

  # GET /pds_equipments/1/edit
  def edit
  end

  # POST /pds_equipments
  # POST /pds_equipments.json
  def create
    @pds_equipment = PdsEquipment.new(pds_equipment_params)

    respond_to do |format|
      if @pds_equipment.save
        format.html { redirect_to @pds_equipment, notice: 'Pds equipment was successfully created.' }
        format.json { render :show, status: :created, location: @pds_equipment }
      else
        format.html { render :new }
        format.json { render json: @pds_equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_equipments/1
  # PATCH/PUT /pds_equipments/1.json
  def update
    respond_to do |format|
      if @pds_equipment.update(pds_equipment_params)
        format.html { redirect_to @pds_equipment, notice: 'Pds equipment was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_equipment }
      else
        format.html { render :edit }
        format.json { render json: @pds_equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_equipments/1
  # DELETE /pds_equipments/1.json
  def destroy
    @pds_equipment.destroy
    respond_to do |format|
      format.html { redirect_to pds_equipments_url, notice: 'Pds equipment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_equipment
      @pds_equipment = PdsEquipment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_equipment_params
      params.require(:pds_equipment).permit(:Project, :sys, :KKS, :eq_type, :Description_RU, :Description_EN, :type_equip, :sd_N)
    end
end
