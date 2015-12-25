class PdsSwitchFixesController < ApplicationController
  before_action :set_pds_switch_fix, only: [:show, :edit, :update, :destroy]

  # GET /pds_switch_fixes
  # GET /pds_switch_fixes.json
  def index
    @pds_switch_fixes = PdsSwitchFix.all
  end

  # GET /pds_switch_fixes/1
  # GET /pds_switch_fixes/1.json
  def show
  end

  # GET /pds_switch_fixes/new
  def new
    @pds_switch_fix = PdsSwitchFix.new
  end

  # GET /pds_switch_fixes/1/edit
  def edit
  end

  # POST /pds_switch_fixes
  # POST /pds_switch_fixes.json
  def create
    @pds_switch_fix = PdsSwitchFix.new(pds_switch_fix_params)

    respond_to do |format|
      if @pds_switch_fix.save
        format.html { redirect_to @pds_switch_fix, notice: 'Pds switch fix was successfully created.' }
        format.json { render :show, status: :created, location: @pds_switch_fix }
      else
        format.html { render :new }
        format.json { render json: @pds_switch_fix.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_switch_fixes/1
  # PATCH/PUT /pds_switch_fixes/1.json
  def update
    respond_to do |format|
      if @pds_switch_fix.update(pds_switch_fix_params)
        format.html { redirect_to @pds_switch_fix, notice: 'Pds switch fix was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_switch_fix }
      else
        format.html { render :edit }
        format.json { render json: @pds_switch_fix.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_switch_fixes/1
  # DELETE /pds_switch_fixes/1.json
  def destroy
    @pds_switch_fix.destroy
    respond_to do |format|
      format.html { redirect_to pds_switch_fixes_url, notice: 'Pds switch fix was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_switch_fix
      @pds_switch_fix = PdsSwitchFix.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_switch_fix_params
      params.require(:pds_switch_fix).permit(:Project, :IC, :sys, :range, :t)
    end
end
