class PdsBreakersController < ApplicationController
  before_action :set_pds_breaker, only: [:show, :edit, :update, :destroy]

  # GET /pds_breakers
  # GET /pds_breakers.json
  def index
    @pds_breakers = PdsBreaker.all
  end

  # GET /pds_breakers/1
  # GET /pds_breakers/1.json
  def show
  end

  # GET /pds_breakers/new
  def new
    @pds_breaker = PdsBreaker.new
  end

  # GET /pds_breakers/1/edit
  def edit
  end

  # POST /pds_breakers
  # POST /pds_breakers.json
  def create
    @pds_breaker = PdsBreaker.new(pds_breaker_params)

    respond_to do |format|
      if @pds_breaker.save
        format.html { redirect_to @pds_breaker, notice: 'Pds breaker was successfully created.' }
        format.json { render :show, status: :created, location: @pds_breaker }
      else
        format.html { render :new }
        format.json { render json: @pds_breaker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_breakers/1
  # PATCH/PUT /pds_breakers/1.json
  def update
    respond_to do |format|
      if @pds_breaker.update(pds_breaker_params)
        format.html { redirect_to @pds_breaker, notice: 'Pds breaker was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_breaker }
      else
        format.html { render :edit }
        format.json { render json: @pds_breaker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_breakers/1
  # DELETE /pds_breakers/1.json
  def destroy
    @pds_breaker.destroy
    respond_to do |format|
      format.html { redirect_to pds_breakers_url, notice: 'Pds breaker was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_breaker
      @pds_breaker = PdsBreaker.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_breaker_params
      params.require(:pds_breaker).permit(:sys, :Project, :tag_RU, :tag_EN, :ed_power, :ctrl_power, :anc_power, :Time, :Algorithm, :Desc_RU, :Desc_EN, :model, :eq_type, :connection, :sd_N)
    end
end
