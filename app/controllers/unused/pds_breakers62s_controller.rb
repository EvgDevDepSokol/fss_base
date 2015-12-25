class PdsBreakers62sController < ApplicationController
  before_action :set_pds_breakers62, only: [:show, :edit, :update, :destroy]

  # GET /pds_breakers62s
  # GET /pds_breakers62s.json
  def index
    @pds_breakers62s = PdsBreakers62.all
  end

  # GET /pds_breakers62s/1
  # GET /pds_breakers62s/1.json
  def show
  end

  # GET /pds_breakers62s/new
  def new
    @pds_breakers62 = PdsBreakers62.new
  end

  # GET /pds_breakers62s/1/edit
  def edit
  end

  # POST /pds_breakers62s
  # POST /pds_breakers62s.json
  def create
    @pds_breakers62 = PdsBreakers62.new(pds_breakers62_params)

    respond_to do |format|
      if @pds_breakers62.save
        format.html { redirect_to @pds_breakers62, notice: 'Pds breakers62 was successfully created.' }
        format.json { render :show, status: :created, location: @pds_breakers62 }
      else
        format.html { render :new }
        format.json { render json: @pds_breakers62.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_breakers62s/1
  # PATCH/PUT /pds_breakers62s/1.json
  def update
    respond_to do |format|
      if @pds_breakers62.update(pds_breakers62_params)
        format.html { redirect_to @pds_breakers62, notice: 'Pds breakers62 was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_breakers62 }
      else
        format.html { render :edit }
        format.json { render json: @pds_breakers62.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_breakers62s/1
  # DELETE /pds_breakers62s/1.json
  def destroy
    @pds_breakers62.destroy
    respond_to do |format|
      format.html { redirect_to pds_breakers62s_url, notice: 'Pds breakers62 was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_breakers62
      @pds_breakers62 = PdsBreakers62.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_breakers62_params
      params.require(:pds_breakers62).permit(:System, :tag_RU, :tag_EN, :Desc_RU, :Desc_EN)
    end
end
