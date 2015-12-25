class PdsRecordersController < ApplicationController
  before_action :set_pds_recorder, only: [:show, :edit, :update, :destroy]

  # GET /pds_recorders
  # GET /pds_recorders.json
  def index
    @pds_recorders = PdsRecorder.all
  end

  # GET /pds_recorders/1
  # GET /pds_recorders/1.json
  def show
  end

  # GET /pds_recorders/new
  def new
    @pds_recorder = PdsRecorder.new
  end

  # GET /pds_recorders/1/edit
  def edit
  end

  # POST /pds_recorders
  # POST /pds_recorders.json
  def create
    @pds_recorder = PdsRecorder.new(pds_recorder_params)

    respond_to do |format|
      if @pds_recorder.save
        format.html { redirect_to @pds_recorder, notice: 'Pds recorder was successfully created.' }
        format.json { render :show, status: :created, location: @pds_recorder }
      else
        format.html { render :new }
        format.json { render json: @pds_recorder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_recorders/1
  # PATCH/PUT /pds_recorders/1.json
  def update
    respond_to do |format|
      if @pds_recorder.update(pds_recorder_params)
        format.html { redirect_to @pds_recorder, notice: 'Pds recorder was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_recorder }
      else
        format.html { render :edit }
        format.json { render json: @pds_recorder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_recorders/1
  # DELETE /pds_recorders/1.json
  def destroy
    @pds_recorder.destroy
    respond_to do |format|
      format.html { redirect_to pds_recorders_url, notice: 'Pds recorder was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_recorder
      @pds_recorder = PdsRecorder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_recorder_params
      params.require(:pds_recorder).permit(:IC, :sys, :Project, :ctrl_power, :t)
    end
end
