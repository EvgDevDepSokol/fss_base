class Api::HwIosignaldefsController < ApplicationController
  before_action :set_hw_iosignaldef, only: %i[show edit update destroy]
  before_action :project, only: :index

  # GET /hw_iosignaldefs
  # GET /hw_iosignaldefs.json
  def index
    @hw_iosignaldefs = HwIosignaldef.order(:ioname)
  end

  # GET /hw_iosignaldefs/1
  # GET /hw_iosignaldefs/1.json
  def show; end

  # GET /hw_iosignaldefs/new
  def new
    @hw_iosignaldef = HwIosignaldef.new
  end

  # GET /hw_iosignaldefs/1/edit
  def edit; end

  # POST /hw_iosignaldefs
  # POST /hw_iosignaldefs.json
  def create
    @hw_iosignaldef = HwIosignaldef.new(hw_iosignaldef_params)

    respond_to do |format|
      if @hw_iosignaldef.save
        format.html { redirect_to @hw_iosignaldef, notice: 'Hw ped was successfully created.' }
        format.json { render :show, status: :created, location: @hw_iosignaldef }
      else
        format.html { render :new }
        format.json { render json: @hw_iosignaldef.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hw_iosignaldefs/1
  # PATCH/PUT /hw_iosignaldefs/1.json
  def update
    respond_to do |format|
      if @hw_iosignaldef.update(hw_iosignaldef_params)
        format.html { redirect_to @hw_iosignaldef, notice: 'Hw ped was successfully updated.' }
        format.json { render :show, status: :ok, location: @hw_iosignaldef }
      else
        format.html { render :edit }
        format.json { render json: @hw_iosignaldef.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hw_iosignaldefs/1
  # DELETE /hw_iosignaldefs/1.json
  def destroy
    @hw_iosignaldef.destroy
    respond_to do |format|
      format.html { redirect_to hw_iosignaldefs_url, notice: 'Hw ped was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_hw_iosignaldef
    @hw_iosignaldef = HwIosignaldef.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def hw_iosignaldef_params
    params[:hw_iosignaldef]
  end

  def project
    @project ||= PdsProject.find_by(ProjectID: params[:pds_project_id])
  end
end
