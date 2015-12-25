class PdsDrsController < ApplicationController
  before_action :set_pds_dr, only: [:show, :edit, :update, :destroy]

  # GET /pds_drs
  # GET /pds_drs.json
  def index
    @pds_drs = PdsDr.all
  end

  # GET /pds_drs/1
  # GET /pds_drs/1.json
  def show
  end

  # GET /pds_drs/new
  def new
    @pds_dr = PdsDr.new
  end

  # GET /pds_drs/1/edit
  def edit
  end

  # POST /pds_drs
  # POST /pds_drs.json
  def create
    @pds_dr = PdsDr.new(pds_dr_params)

    respond_to do |format|
      if @pds_dr.save
        format.html { redirect_to @pds_dr, notice: 'Pds dr was successfully created.' }
        format.json { render :show, status: :created, location: @pds_dr }
      else
        format.html { render :new }
        format.json { render json: @pds_dr.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_drs/1
  # PATCH/PUT /pds_drs/1.json
  def update
    respond_to do |format|
      if @pds_dr.update(pds_dr_params)
        format.html { redirect_to @pds_dr, notice: 'Pds dr was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_dr }
      else
        format.html { render :edit }
        format.json { render json: @pds_dr.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_drs/1
  # DELETE /pds_drs/1.json
  def destroy
    @pds_dr.destroy
    respond_to do |format|
      format.html { redirect_to pds_drs_url, notice: 'Pds dr was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_dr
      @pds_dr = PdsDr.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_dr_params
      params.require(:pds_dr).permit(:sys, :Project, :drNum, :stage, :drAuthor_text, :drAuthor, :rfr, :closed, :createDate, :expRespDate, :query, :reply, :sentForRev, :replyAuthor_text, :replyAuthor, :closedBy, :openedDate, :inprogressDate, :replyDate, :closedDate, :NameDr, :Status, :IC, :PowerState, :Priority, :Disparity, :CommingResult)
    end
end
