class PdsBreakers60sController < ApplicationController
  before_action :set_pds_breakers60, only: [:show, :edit, :update, :destroy]

  # GET /pds_breakers60s
  # GET /pds_breakers60s.json
  def index
    @pds_breakers60s = PdsBreakers60.all
  end

  # GET /pds_breakers60s/1
  # GET /pds_breakers60s/1.json
  def show
  end

  # GET /pds_breakers60s/new
  def new
    @pds_breakers60 = PdsBreakers60.new
  end

  # GET /pds_breakers60s/1/edit
  def edit
  end

  # POST /pds_breakers60s
  # POST /pds_breakers60s.json
  def create
    @pds_breakers60 = PdsBreakers60.new(pds_breakers60_params)

    respond_to do |format|
      if @pds_breakers60.save
        format.html { redirect_to @pds_breakers60, notice: 'Pds breakers60 was successfully created.' }
        format.json { render :show, status: :created, location: @pds_breakers60 }
      else
        format.html { render :new }
        format.json { render json: @pds_breakers60.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_breakers60s/1
  # PATCH/PUT /pds_breakers60s/1.json
  def update
    respond_to do |format|
      if @pds_breakers60.update(pds_breakers60_params)
        format.html { redirect_to @pds_breakers60, notice: 'Pds breakers60 was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_breakers60 }
      else
        format.html { render :edit }
        format.json { render json: @pds_breakers60.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_breakers60s/1
  # DELETE /pds_breakers60s/1.json
  def destroy
    @pds_breakers60.destroy
    respond_to do |format|
      format.html { redirect_to pds_breakers60s_url, notice: 'Pds breakers60 was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_breakers60
      @pds_breakers60 = PdsBreakers60.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_breakers60_params
      params.require(:pds_breakers60).permit(:System, :tag_RU, :tag_EN, :Desc_RU, :Desc_EN)
    end
end
