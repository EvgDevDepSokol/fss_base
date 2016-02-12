class Api::HwPedsController < ApplicationController
  before_action :set_hw_ped, only: [:show, :edit, :update, :destroy]
  before_action :project, only: :index

  # GET /hw_peds
  # GET /hw_peds.json
  def index
    @hw_peds = HwPed.where(Project: project.ProjectID)
  end

  # GET /hw_peds/1
  # GET /hw_peds/1.json
  def show
  end

  # GET /hw_peds/new
  def new
    @hw_ped = HwPed.new
  end

  # GET /hw_peds/1/edit
  def edit
  end

  # POST /hw_peds
  # POST /hw_peds.json
  def create
    @hw_ped = HwPed.new(hw_ped_params)

    respond_to do |format|
      if @hw_ped.save
        format.html { redirect_to @hw_ped, notice: 'Hw ped was successfully created.' }
        format.json { render :show, status: :created, location: @hw_ped }
      else
        format.html { render :new }
        format.json { render json: @hw_ped.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hw_peds/1
  # PATCH/PUT /hw_peds/1.json
  def update
    respond_to do |format|
      if @hw_ped.update(hw_ped_params)
        format.html { redirect_to @hw_ped, notice: 'Hw ped was successfully updated.' }
        format.json { render :show, status: :ok, location: @hw_ped }
      else
        format.html { render :edit }
        format.json { render json: @hw_ped.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hw_peds/1
  # DELETE /hw_peds/1.json
  def destroy
    @hw_ped.destroy
    respond_to do |format|
      format.html { redirect_to hw_peds_url, notice: 'Hw ped was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hw_ped
      @hw_ped = HwPed.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hw_ped_params
      params[:hw_ped]
    end

    def project
      @project ||= PdsProject.find_by(ProjectID: params[:pds_project_id])
    end   
end
