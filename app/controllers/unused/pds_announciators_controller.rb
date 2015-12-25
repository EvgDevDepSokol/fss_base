class PdsAnnounciatorsController < ApplicationController
  before_action :set_pds_announciator, only: [:show, :edit, :update, :destroy]

  # GET /pds_announciators
  # GET /pds_announciators.json
  def index
    @pds_announciators = PdsAnnounciator.all
  end

  # GET /pds_announciators/1
  # GET /pds_announciators/1.json
  def show
  end

  # GET /pds_announciators/new
  def new
    @pds_announciator = PdsAnnounciator.new
  end

  # GET /pds_announciators/1/edit
  def edit
  end

  # POST /pds_announciators
  # POST /pds_announciators.json
  def create
    @pds_announciator = PdsAnnounciator.new(pds_announciator_params)

    respond_to do |format|
      if @pds_announciator.save
        format.html { redirect_to @pds_announciator, notice: 'Pds announciator was successfully created.' }
        format.json { render :show, status: :created, location: @pds_announciator }
      else
        format.html { render :new }
        format.json { render json: @pds_announciator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_announciators/1
  # PATCH/PUT /pds_announciators/1.json
  def update
    respond_to do |format|
      if @pds_announciator.update(pds_announciator_params)
        format.html { redirect_to @pds_announciator, notice: 'Pds announciator was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_announciator }
      else
        format.html { render :edit }
        format.json { render json: @pds_announciator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_announciators/1
  # DELETE /pds_announciators/1.json
  def destroy
    @pds_announciator.destroy
    respond_to do |format|
      format.html { redirect_to pds_announciators_url, notice: 'Pds announciator was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_announciator
      @pds_announciator = PdsAnnounciator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_announciator_params
      params.require(:pds_announciator).permit(:IC, :Project, :sys, :ctrl_power, :t, :Type, :Gr_Dreg, :Detector, :Characteristics, :sign, :Code)
    end
end
