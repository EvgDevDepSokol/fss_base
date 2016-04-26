class Api::PdsSyslistsController < ApplicationController
  before_action :set_pds_syslist, only: [:show, :edit, :update, :destroy]

  # GET /pds_syslists
  # GET /pds_syslists.json
  def index
    @pds_syslists = PdsSyslist.order('System').all
  end

  # GET /pds_syslists/1
  # GET /pds_syslists/1.json
  def show
  end

  # GET /pds_syslists/new
  def new
    @pds_syslist = PdsSyslist.new
  end

  # GET /pds_syslists/1/edit
  def edit
  end

  # POST /pds_syslists
  # POST /pds_syslists.json
  def create
    @pds_syslist = PdsSyslist.new(pds_syslist_params)

    respond_to do |format|
      if @pds_syslist.save
        format.html { redirect_to @pds_syslist, notice: 'Pds syslist was successfully created.' }
        format.json { render :show, status: :created, location: @pds_syslist }
      else
        format.html { render :new }
        format.json { render json: @pds_syslist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_syslists/1
  # PATCH/PUT /pds_syslists/1.json
  def update
    respond_to do |format|
      if @pds_syslist.update(pds_syslist_params)
        format.html { redirect_to @pds_syslist, notice: 'Pds syslist was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_syslist }
      else
        format.html { render :edit }
        format.json { render json: @pds_syslist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_syslists/1
  # DELETE /pds_syslists/1.json
  def destroy
    @pds_syslist.destroy
    respond_to do |format|
      format.html { redirect_to pds_syslists_url, notice: 'Pds syslist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_pds_syslist
    @pds_syslist = PdsSyslist.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pds_syslist_params
    params.require(:pds_syslist).permit(:System, :Descriptor, :Category, :shortDesc, :shortDesc_EN, :t)
  end
end
