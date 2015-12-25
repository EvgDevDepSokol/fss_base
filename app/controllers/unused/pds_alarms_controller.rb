class PdsAlarmsController < ApplicationController
  before_action :set_pds_alarm, only: [:show, :edit, :update, :destroy]

  # GET /pds_alarms
  # GET /pds_alarms.json
  def index
    @pds_alarms = PdsAlarm.all
  end

  # GET /pds_alarms/1
  # GET /pds_alarms/1.json
  def show
  end

  # GET /pds_alarms/new
  def new
    @pds_alarm = PdsAlarm.new
  end

  # GET /pds_alarms/1/edit
  def edit
  end

  # POST /pds_alarms
  # POST /pds_alarms.json
  def create
    @pds_alarm = PdsAlarm.new(pds_alarm_params)

    respond_to do |format|
      if @pds_alarm.save
        format.html { redirect_to @pds_alarm, notice: 'Pds alarm was successfully created.' }
        format.json { render :show, status: :created, location: @pds_alarm }
      else
        format.html { render :new }
        format.json { render json: @pds_alarm.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_alarms/1
  # PATCH/PUT /pds_alarms/1.json
  def update
    respond_to do |format|
      if @pds_alarm.update(pds_alarm_params)
        format.html { redirect_to @pds_alarm, notice: 'Pds alarm was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_alarm }
      else
        format.html { render :edit }
        format.json { render json: @pds_alarm.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_alarms/1
  # DELETE /pds_alarms/1.json
  def destroy
    @pds_alarm.destroy
    respond_to do |format|
      format.html { redirect_to pds_alarms_url, notice: 'Pds alarm was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_alarm
      @pds_alarm = PdsAlarm.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_alarm_params
      params.require(:pds_alarm).permit(:IC, :sys, :Project, :t)
    end
end
