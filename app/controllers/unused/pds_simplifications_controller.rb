class PdsSimplificationsController < ApplicationController
  before_action :set_pds_simplification, only: [:show, :edit, :update, :destroy]

  # GET /pds_simplifications
  # GET /pds_simplifications.json
  def index
    @pds_simplifications = PdsSimplification.all
  end

  # GET /pds_simplifications/1
  # GET /pds_simplifications/1.json
  def show
  end

  # GET /pds_simplifications/new
  def new
    @pds_simplification = PdsSimplification.new
  end

  # GET /pds_simplifications/1/edit
  def edit
  end

  # POST /pds_simplifications
  # POST /pds_simplifications.json
  def create
    @pds_simplification = PdsSimplification.new(pds_simplification_params)

    respond_to do |format|
      if @pds_simplification.save
        format.html { redirect_to @pds_simplification, notice: 'Pds simplification was successfully created.' }
        format.json { render :show, status: :created, location: @pds_simplification }
      else
        format.html { render :new }
        format.json { render json: @pds_simplification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_simplifications/1
  # PATCH/PUT /pds_simplifications/1.json
  def update
    respond_to do |format|
      if @pds_simplification.update(pds_simplification_params)
        format.html { redirect_to @pds_simplification, notice: 'Pds simplification was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_simplification }
      else
        format.html { render :edit }
        format.json { render json: @pds_simplification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_simplifications/1
  # DELETE /pds_simplifications/1.json
  def destroy
    @pds_simplification.destroy
    respond_to do |format|
      format.html { redirect_to pds_simplifications_url, notice: 'Pds simplification was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_simplification
      @pds_simplification = PdsSimplification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_simplification_params
      params.require(:pds_simplification).permit(:sys, :Project, :Numb, :Desc, :Desc_EN, :support, :support_EN, :queryID, :t)
    end
end
