class Api::HwDevtypesController < ApplicationController
  before_action :set_hw_devtype, only: [:show, :edit, :update, :destroy]

  # GET /hw_devtypes
  # GET /hw_devtypes.json
  def index
    @hw_devtypes = HwDevtype.all.order(:RuName)
  end

  # GET /hw_devtypes/1
  # GET /hw_devtypes/1.json
  def show
  end

  # GET /hw_devtypes/new
  def new
    @hw_devtype = HwDevtype.new
  end

  # GET /hw_devtypes/1/edit
  def edit
  end

  # POST /hw_devtypes
  # POST /hw_devtypes.json
  def create
    @hw_devtype = HwDevtype.new(hw_devtype_params)

    respond_to do |format|
      if @hw_devtype.save
        format.html { redirect_to @hw_devtype, notice: 'Hw devtype was successfully created.' }
        format.json { render :show, status: :created, location: @hw_devtype }
      else
        format.html { render :new }
        format.json { render json: @hw_devtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hw_devtypes/1
  # PATCH/PUT /hw_devtypes/1.json
  def update
    respond_to do |format|
      if @hw_devtype.update(hw_devtype_params)
        format.html { redirect_to @hw_devtype, notice: 'Hw devtype was successfully updated.' }
        format.json { render :show, status: :ok, location: @hw_devtype }
      else
        format.html { render :edit }
        format.json { render json: @hw_devtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hw_devtypes/1
  # DELETE /hw_devtypes/1.json
  def destroy
    @hw_devtype.destroy
    respond_to do |format|
      format.html { redirect_to hw_devtypes_url, notice: 'Hw devtype was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_hw_devtype
    @hw_devtype = HwDevtype.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def hw_devtype_params
    params.require(:hw_devtype).permit(:RuName, :EnName, :typetable)
  end
end
