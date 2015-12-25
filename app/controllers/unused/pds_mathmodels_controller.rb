class PdsMathmodelsController < ApplicationController
  before_action :set_pds_mathmodel, only: [:show, :edit, :update, :destroy]

  # GET /pds_mathmodels
  # GET /pds_mathmodels.json
  def index
    @pds_mathmodels = PdsMathmodel.all
  end

  # GET /pds_mathmodels/1
  # GET /pds_mathmodels/1.json
  def show
  end

  # GET /pds_mathmodels/new
  def new
    @pds_mathmodel = PdsMathmodel.new
  end

  # GET /pds_mathmodels/1/edit
  def edit
  end

  # POST /pds_mathmodels
  # POST /pds_mathmodels.json
  def create
    @pds_mathmodel = PdsMathmodel.new(pds_mathmodel_params)

    respond_to do |format|
      if @pds_mathmodel.save
        format.html { redirect_to @pds_mathmodel, notice: 'Pds mathmodel was successfully created.' }
        format.json { render :show, status: :created, location: @pds_mathmodel }
      else
        format.html { render :new }
        format.json { render json: @pds_mathmodel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_mathmodels/1
  # PATCH/PUT /pds_mathmodels/1.json
  def update
    respond_to do |format|
      if @pds_mathmodel.update(pds_mathmodel_params)
        format.html { redirect_to @pds_mathmodel, notice: 'Pds mathmodel was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_mathmodel }
      else
        format.html { render :edit }
        format.json { render json: @pds_mathmodel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_mathmodels/1
  # DELETE /pds_mathmodels/1.json
  def destroy
    @pds_mathmodel.destroy
    respond_to do |format|
      format.html { redirect_to pds_mathmodels_url, notice: 'Pds mathmodel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_mathmodel
      @pds_mathmodel = PdsMathmodel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_mathmodel_params
      params.require(:pds_mathmodel).permit(:Project, :sys, :task_N, :Desc_RU, :Desc_EN)
    end
end
