class Api::PdsDetectorsController < ApplicationController
  before_action :set_pds_detector, only: [:show, :edit, :update, :destroy]

  # GET /pds_detectors
  # GET /pds_detectors.json
  def index
    # todo fix limit
    @pds_detectors = PdsDetector.limit(1000)
  end

  # GET /pds_detectors/1
  # GET /pds_detectors/1.json
  def show
  end

  # GET /pds_detectors/new
  def new
    @pds_detector = PdsDetector.new
  end

  # GET /pds_detectors/1/edit
  def edit
  end

  # POST /pds_detectors
  # POST /pds_detectors.json
  def create
    @pds_detector = PdsDetector.new(pds_detector_params)

    respond_to do |format|
      if @pds_detector.save
        format.html { redirect_to @pds_detector, notice: 'Pds detector was successfully created.' }
        format.json { render :show, status: :created, location: @pds_detector }
      else
        format.html { render :new }
        format.json { render json: @pds_detector.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_detectors/1
  # PATCH/PUT /pds_detectors/1.json
  def update
    respond_to do |format|
      if @pds_detector.update(pds_detector_params)
        puts 'if'
        format.html { redirect_to @pds_detector, notice: 'Pds detector was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_detector }
      else
        puts 'else'
        format.html { render :edit }
        format.json { render json: @pds_detector.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_detectors/1
  # DELETE /pds_detectors/1.json
  def destroy
    @pds_detector.destroy
    respond_to do |format|
      format.html { redirect_to pds_detectors_url, notice: 'Pds detector was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_detector
      @pds_detector = PdsDetector.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_detector_params
      #params.require(:pds_detector).permit(:Project, :sys, :station_sys, :tag, :tag_RU, :Desc, :Desc_EN, :Group_N, :ctrl_power, :nom_state, :low_lim, :up_lim, :LA, :HA, :LW, :HW, :LT, :HT, :Unit, :1coef_shift, :2coef_scale, :sluggishness, :scale_noise, :sd_N, :doc_reg_N, :Func, :t, :Type, :TypeDetec, :Room, :SPTable, :SCK_input, :SP_1, :SP_2, :SP_3, :SPT_ACTION, :SPT_COMMENT, :DREG_input, :TimeConst, :power, :varible, :import_t, :mod, :eq_type, :alg_type)
    end
end
