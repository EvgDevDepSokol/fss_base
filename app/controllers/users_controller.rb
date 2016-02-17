class UsersController < ApplicationController
  #before_action :set_pds_engineer, only: [:show, :edit, :update, :destroy]
  # GET /pds_engineers
  # GET /pds_engineers.json
  def index
    @users = PdsEngineer.all
  end

  # GET /pds_engineers/1
  # GET /pds_engineers/1.json
  def show
  end

  # GET /pds_engineers/new
  def new
    @pds_engineer = PdsEngineer.new
  end

  # GET /pds_engineers/1/edit
  def edit
  end

  # POST /pds_engineers
  # POST /pds_engineers.json
  def create
    @pds_engineer = PdsEngineer.new(pds_engineer_params)

    respond_to do |format|
      if @pds_engineer.save
        format.html { redirect_to @pds_engineer, notice: 'Pds engineer was successfully created.' }
        format.json { render :show, status: :created, location: @pds_engineer }
      else
        format.html { render :new }
        format.json { render json: @pds_engineer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_engineers/1
  # PATCH/PUT /pds_engineers/1.json
  def update
    respond_to do |format|
      if @pds_engineer.update(pds_engineer_params)
        format.html { redirect_to @pds_engineer, notice: 'Pds engineer was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_engineer }
      else
        format.html { render :edit }
        format.json { render json: @pds_engineer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_engineers/1
  # DELETE /pds_engineers/1.json
  def destroy
    @pds_engineer.destroy
    respond_to do |format|
      format.html { redirect_to pds_engineers_url, notice: 'Pds engineer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_pds_engineer
    @pds_engineer = PdsEngineer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pds_engineer_params
    params.require(:pds_engineer).permit(:name, :TH, :TO, :L, :EL, :CR, :D, :SWM, :HWM, :PM, :t, :EMail, :CheifDirector, :login, :pwd, :dismiss, :coreID, :phoneNum, :cellNum, :IP, :compJack, :phoneJack, :sectorID1, :enabled)
  end
end
