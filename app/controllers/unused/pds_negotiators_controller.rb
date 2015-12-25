class PdsNegotiatorsController < ApplicationController
  before_action :set_pds_negotiator, only: [:show, :edit, :update, :destroy]

  # GET /pds_negotiators
  # GET /pds_negotiators.json
  def index
    @pds_negotiators = PdsNegotiator.all
  end

  # GET /pds_negotiators/1
  # GET /pds_negotiators/1.json
  def show
  end

  # GET /pds_negotiators/new
  def new
    @pds_negotiator = PdsNegotiator.new
  end

  # GET /pds_negotiators/1/edit
  def edit
  end

  # POST /pds_negotiators
  # POST /pds_negotiators.json
  def create
    @pds_negotiator = PdsNegotiator.new(pds_negotiator_params)

    respond_to do |format|
      if @pds_negotiator.save
        format.html { redirect_to @pds_negotiator, notice: 'Pds negotiator was successfully created.' }
        format.json { render :show, status: :created, location: @pds_negotiator }
      else
        format.html { render :new }
        format.json { render json: @pds_negotiator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_negotiators/1
  # PATCH/PUT /pds_negotiators/1.json
  def update
    respond_to do |format|
      if @pds_negotiator.update(pds_negotiator_params)
        format.html { redirect_to @pds_negotiator, notice: 'Pds negotiator was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_negotiator }
      else
        format.html { render :edit }
        format.json { render json: @pds_negotiator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_negotiators/1
  # DELETE /pds_negotiators/1.json
  def destroy
    @pds_negotiator.destroy
    respond_to do |format|
      format.html { redirect_to pds_negotiators_url, notice: 'Pds negotiator was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_negotiator
      @pds_negotiator = PdsNegotiator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_negotiator_params
      params.require(:pds_negotiator).permit(:name, :post, :Project, :chef, :ord)
    end
end
