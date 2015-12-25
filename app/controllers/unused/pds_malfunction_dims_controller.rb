class PdsMalfunctionDimsController < ApplicationController
  before_action :set_pds_malfunction_dim, only: [:show, :edit, :update, :destroy]

  # GET /pds_malfunction_dims
  # GET /pds_malfunction_dims.json
  def index
    @pds_malfunction_dims = PdsMalfunctionDim.all
  end

  # GET /pds_malfunction_dims/1
  # GET /pds_malfunction_dims/1.json
  def show
  end

  # GET /pds_malfunction_dims/new
  def new
    @pds_malfunction_dim = PdsMalfunctionDim.new
  end

  # GET /pds_malfunction_dims/1/edit
  def edit
  end

  # POST /pds_malfunction_dims
  # POST /pds_malfunction_dims.json
  def create
    @pds_malfunction_dim = PdsMalfunctionDim.new(pds_malfunction_dim_params)

    respond_to do |format|
      if @pds_malfunction_dim.save
        format.html { redirect_to @pds_malfunction_dim, notice: 'Pds malfunction dim was successfully created.' }
        format.json { render :show, status: :created, location: @pds_malfunction_dim }
      else
        format.html { render :new }
        format.json { render json: @pds_malfunction_dim.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_malfunction_dims/1
  # PATCH/PUT /pds_malfunction_dims/1.json
  def update
    respond_to do |format|
      if @pds_malfunction_dim.update(pds_malfunction_dim_params)
        format.html { redirect_to @pds_malfunction_dim, notice: 'Pds malfunction dim was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_malfunction_dim }
      else
        format.html { render :edit }
        format.json { render json: @pds_malfunction_dim.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_malfunction_dims/1
  # DELETE /pds_malfunction_dims/1.json
  def destroy
    @pds_malfunction_dim.destroy
    respond_to do |format|
      format.html { redirect_to pds_malfunction_dims_url, notice: 'Pds malfunction dim was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_malfunction_dim
      @pds_malfunction_dim = PdsMalfunctionDim.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_malfunction_dim_params
      params.require(:pds_malfunction_dim).permit(:Project, :Malfunction, :Character, :Target_EN, :Target, :sd_N, :is_main)
    end
end
