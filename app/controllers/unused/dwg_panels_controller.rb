class DwgPanelsController < ApplicationController
  before_action :set_dwg_panel, only: [:show, :edit, :update, :destroy]

  # GET /dwg_panels
  # GET /dwg_panels.json
  def index
    @dwg_panels = DwgPanel.all
  end

  # GET /dwg_panels/1
  # GET /dwg_panels/1.json
  def show
  end

  # GET /dwg_panels/new
  def new
    @dwg_panel = DwgPanel.new
  end

  # GET /dwg_panels/1/edit
  def edit
  end

  # POST /dwg_panels
  # POST /dwg_panels.json
  def create
    @dwg_panel = DwgPanel.new(dwg_panel_params)

    respond_to do |format|
      if @dwg_panel.save
        format.html { redirect_to @dwg_panel, notice: 'Dwg panel was successfully created.' }
        format.json { render :show, status: :created, location: @dwg_panel }
      else
        format.html { render :new }
        format.json { render json: @dwg_panel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dwg_panels/1
  # PATCH/PUT /dwg_panels/1.json
  def update
    respond_to do |format|
      if @dwg_panel.update(dwg_panel_params)
        format.html { redirect_to @dwg_panel, notice: 'Dwg panel was successfully updated.' }
        format.json { render :show, status: :ok, location: @dwg_panel }
      else
        format.html { render :edit }
        format.json { render json: @dwg_panel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dwg_panels/1
  # DELETE /dwg_panels/1.json
  def destroy
    @dwg_panel.destroy
    respond_to do |format|
      format.html { redirect_to dwg_panels_url, notice: 'Dwg panel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dwg_panel
      @dwg_panel = DwgPanel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dwg_panel_params
      params.require(:dwg_panel).permit(:Project, :panel, :NAME, :EV, :EH, :SV, :SH, :MP_CMEMO, :MP_CODE, :MP_CODE1, :MP_CODE2, :MP_L0, :MP_L0_0, :MP_L0_1, :MP_L0_2, :MP_L0_3, :MP_L0_4, :MP_L0_0_x, :MP_L0_0_y, :MP_L0_0_w, :MP_L0_0_h, :MP_L0_0_f, :MP_L0_1_x, :MP_L0_1_y, :MP_L0_1_w, :MP_L0_1_h, :MP_L0_1_f, :MP_L0_2_x, :MP_L0_2_y, :MP_L0_2_w, :MP_L0_2_h, :MP_L0_2_f, :MP_L0_3_x, :MP_L0_3_y, :MP_L0_3_w, :MP_L0_3_h, :MP_L0_3_f, :MP_L0_4_x, :MP_L0_4_y, :MP_L0_4_w, :MP_L0_4_h, :MP_L0_4_f, :MP_MASS, :MP_MAX, :MP_MIN, :MP_MODE, :MP_MODEORD, :MP_NAME0, :MP_NAME1, :MP_ORDER, :MP_PROJ, :MP_S0, :MP_S100, :MP_S20, :MP_S40, :MP_S50, :MP_S60, :MP_S80, :MP_TYPE0, :MP_TYPE1, :MP_U0, :MP_U1, :MP_IO, :MP_IOCONT, :MP_IONAME, :TYPE, :FONT, :MIRROR, :ROTATE, :revision, :t, :rotation, :ref)
    end
end
