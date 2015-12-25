class PdsBreakers73sController < ApplicationController
  before_action :set_pds_breakers73, only: [:show, :edit, :update, :destroy]

  # GET /pds_breakers73s
  # GET /pds_breakers73s.json
  def index
    @pds_breakers73s = PdsBreakers73.all
  end

  # GET /pds_breakers73s/1
  # GET /pds_breakers73s/1.json
  def show
  end

  # GET /pds_breakers73s/new
  def new
    @pds_breakers73 = PdsBreakers73.new
  end

  # GET /pds_breakers73s/1/edit
  def edit
  end

  # POST /pds_breakers73s
  # POST /pds_breakers73s.json
  def create
    @pds_breakers73 = PdsBreakers73.new(pds_breakers73_params)

    respond_to do |format|
      if @pds_breakers73.save
        format.html { redirect_to @pds_breakers73, notice: 'Pds breakers73 was successfully created.' }
        format.json { render :show, status: :created, location: @pds_breakers73 }
      else
        format.html { render :new }
        format.json { render json: @pds_breakers73.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_breakers73s/1
  # PATCH/PUT /pds_breakers73s/1.json
  def update
    respond_to do |format|
      if @pds_breakers73.update(pds_breakers73_params)
        format.html { redirect_to @pds_breakers73, notice: 'Pds breakers73 was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_breakers73 }
      else
        format.html { render :edit }
        format.json { render json: @pds_breakers73.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_breakers73s/1
  # DELETE /pds_breakers73s/1.json
  def destroy
    @pds_breakers73.destroy
    respond_to do |format|
      format.html { redirect_to pds_breakers73s_url, notice: 'Pds breakers73 was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_breakers73
      @pds_breakers73 = PdsBreakers73.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_breakers73_params
      params.require(:pds_breakers73).permit(:System, :tag_RU, :tag_EN, :Desc_RU, :Desc_EN)
    end
end
