class PdsProjectSiesController < ApplicationController
  before_action :set_pds_project_sy, only: [:show, :edit, :update, :destroy]

  # GET /pds_project_sies
  # GET /pds_project_sies.json
  def index
    @pds_project_sies = PdsProjectSy.all
  end

  # GET /pds_project_sies/1
  # GET /pds_project_sies/1.json
  def show
  end

  # GET /pds_project_sies/new
  def new
    @pds_project_sy = PdsProjectSy.new
  end

  # GET /pds_project_sies/1/edit
  def edit
  end

  # POST /pds_project_sies
  # POST /pds_project_sies.json
  def create
    @pds_project_sy = PdsProjectSy.new(pds_project_sy_params)

    respond_to do |format|
      if @pds_project_sy.save
        format.html { redirect_to @pds_project_sy, notice: 'Pds project sy was successfully created.' }
        format.json { render :show, status: :created, location: @pds_project_sy }
      else
        format.html { render :new }
        format.json { render json: @pds_project_sy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_project_sies/1
  # PATCH/PUT /pds_project_sies/1.json
  def update
    respond_to do |format|
      if @pds_project_sy.update(pds_project_sy_params)
        format.html { redirect_to @pds_project_sy, notice: 'Pds project sy was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_project_sy }
      else
        format.html { render :edit }
        format.json { render json: @pds_project_sy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_project_sies/1
  # DELETE /pds_project_sies/1.json
  def destroy
    @pds_project_sy.destroy
    respond_to do |format|
      format.html { redirect_to pds_project_sies_url, notice: 'Pds project sy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_project_sy
      @pds_project_sy = PdsProjectSy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_project_sy_params
      params.require(:pds_project_sy).permit(:Project, :Station_sys, :sys, :Desc_RU, :Desc_EN, :t)
    end
end
