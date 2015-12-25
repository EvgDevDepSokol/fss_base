class PdsSwitchNofixesController < ApplicationController
  before_action :set_pds_switch_nofix, only: [:show, :edit, :update, :destroy]

  # GET /pds_switch_nofixes
  # GET /pds_switch_nofixes.json
  def index
    @pds_switch_nofixes = PdsSwitchNofix.all
  end

  # GET /pds_switch_nofixes/1
  # GET /pds_switch_nofixes/1.json
  def show
  end

  # GET /pds_switch_nofixes/new
  def new
    @pds_switch_nofix = PdsSwitchNofix.new
  end

  # GET /pds_switch_nofixes/1/edit
  def edit
  end

  # POST /pds_switch_nofixes
  # POST /pds_switch_nofixes.json
  def create
    @pds_switch_nofix = PdsSwitchNofix.new(pds_switch_nofix_params)

    respond_to do |format|
      if @pds_switch_nofix.save
        format.html { redirect_to @pds_switch_nofix, notice: 'Pds switch nofix was successfully created.' }
        format.json { render :show, status: :created, location: @pds_switch_nofix }
      else
        format.html { render :new }
        format.json { render json: @pds_switch_nofix.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_switch_nofixes/1
  # PATCH/PUT /pds_switch_nofixes/1.json
  def update
    respond_to do |format|
      if @pds_switch_nofix.update(pds_switch_nofix_params)
        format.html { redirect_to @pds_switch_nofix, notice: 'Pds switch nofix was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_switch_nofix }
      else
        format.html { render :edit }
        format.json { render json: @pds_switch_nofix.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_switch_nofixes/1
  # DELETE /pds_switch_nofixes/1.json
  def destroy
    @pds_switch_nofix.destroy
    respond_to do |format|
      format.html { redirect_to pds_switch_nofixes_url, notice: 'Pds switch nofix was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_switch_nofix
      @pds_switch_nofix = PdsSwitchNofix.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_switch_nofix_params
      params.require(:pds_switch_nofix).permit(:Project, :IC, :sys, :range, :t)
    end
end
