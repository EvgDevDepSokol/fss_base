class PdsEjectorsController < ApplicationController
  before_action :set_pds_ejector, only: [:show, :edit, :update, :destroy]

  # GET /pds_ejectors
  # GET /pds_ejectors.json
  def index
    @pds_ejectors = PdsEjector.all
  end

  # GET /pds_ejectors/1
  # GET /pds_ejectors/1.json
  def show
  end

  # GET /pds_ejectors/new
  def new
    @pds_ejector = PdsEjector.new
  end

  # GET /pds_ejectors/1/edit
  def edit
  end

  # POST /pds_ejectors
  # POST /pds_ejectors.json
  def create
    @pds_ejector = PdsEjector.new(pds_ejector_params)

    respond_to do |format|
      if @pds_ejector.save
        format.html { redirect_to @pds_ejector, notice: 'Pds ejector was successfully created.' }
        format.json { render :show, status: :created, location: @pds_ejector }
      else
        format.html { render :new }
        format.json { render json: @pds_ejector.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_ejectors/1
  # PATCH/PUT /pds_ejectors/1.json
  def update
    respond_to do |format|
      if @pds_ejector.update(pds_ejector_params)
        format.html { redirect_to @pds_ejector, notice: 'Pds ejector was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_ejector }
      else
        format.html { render :edit }
        format.json { render json: @pds_ejector.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_ejectors/1
  # DELETE /pds_ejectors/1.json
  def destroy
    @pds_ejector.destroy
    respond_to do |format|
      format.html { redirect_to pds_ejectors_url, notice: 'Pds ejector was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_ejector
      @pds_ejector = PdsEjector.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_ejector_params
      params.require(:pds_ejector).permit(:kks, :ShortDesc, :Desc_EN, :capacity, :level, :room, :Project, :sys, :eq_type, :Unit, :sd_N)
    end
end
