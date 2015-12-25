class PdsAlgTypesController < ApplicationController
  before_action :set_pds_alg_type, only: [:show, :edit, :update, :destroy]

  # GET /pds_alg_types
  # GET /pds_alg_types.json
  def index
    @pds_alg_types = PdsAlgType.all
  end

  # GET /pds_alg_types/1
  # GET /pds_alg_types/1.json
  def show
  end

  # GET /pds_alg_types/new
  def new
    @pds_alg_type = PdsAlgType.new
  end

  # GET /pds_alg_types/1/edit
  def edit
  end

  # POST /pds_alg_types
  # POST /pds_alg_types.json
  def create
    @pds_alg_type = PdsAlgType.new(pds_alg_type_params)

    respond_to do |format|
      if @pds_alg_type.save
        format.html { redirect_to @pds_alg_type, notice: 'Pds alg type was successfully created.' }
        format.json { render :show, status: :created, location: @pds_alg_type }
      else
        format.html { render :new }
        format.json { render json: @pds_alg_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_alg_types/1
  # PATCH/PUT /pds_alg_types/1.json
  def update
    respond_to do |format|
      if @pds_alg_type.update(pds_alg_type_params)
        format.html { redirect_to @pds_alg_type, notice: 'Pds alg type was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_alg_type }
      else
        format.html { render :edit }
        format.json { render json: @pds_alg_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_alg_types/1
  # DELETE /pds_alg_types/1.json
  def destroy
    @pds_alg_type.destroy
    respond_to do |format|
      format.html { redirect_to pds_alg_types_url, notice: 'Pds alg type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_alg_type
      @pds_alg_type = PdsAlgType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_alg_type_params
      params.require(:pds_alg_type).permit(:Project, :alg_type, :numb)
    end
end
