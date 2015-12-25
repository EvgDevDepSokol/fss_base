class PdsPpcdsController < ApplicationController
  before_action :set_pds_ppcd, only: [:show, :edit, :update, :destroy]

  # GET /pds_ppcds
  # GET /pds_ppcds.json
  def index
    @pds_ppcds = PdsPpcd.all
  end

  # GET /pds_ppcds/1
  # GET /pds_ppcds/1.json
  def show
  end

  # GET /pds_ppcds/new
  def new
    @pds_ppcd = PdsPpcd.new
  end

  # GET /pds_ppcds/1/edit
  def edit
  end

  # POST /pds_ppcds
  # POST /pds_ppcds.json
  def create
    @pds_ppcd = PdsPpcd.new(pds_ppcd_params)

    respond_to do |format|
      if @pds_ppcd.save
        format.html { redirect_to @pds_ppcd, notice: 'Pds ppcd was successfully created.' }
        format.json { render :show, status: :created, location: @pds_ppcd }
      else
        format.html { render :new }
        format.json { render json: @pds_ppcd.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_ppcds/1
  # PATCH/PUT /pds_ppcds/1.json
  def update
    respond_to do |format|
      if @pds_ppcd.update(pds_ppcd_params)
        format.html { redirect_to @pds_ppcd, notice: 'Pds ppcd was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_ppcd }
      else
        format.html { render :edit }
        format.json { render json: @pds_ppcd.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_ppcds/1
  # DELETE /pds_ppcds/1.json
  def destroy
    @pds_ppcd.destroy
    respond_to do |format|
      format.html { redirect_to pds_ppcds_url, notice: 'Pds ppcd was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_ppcd
      @pds_ppcd = PdsPpcd.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_ppcd_params
      params.require(:pds_ppcd).permit(:Project, :sys, :Shifr, :Key, :identif, :Description, :Description_EN, :Detector, :t, :code)
    end
end
