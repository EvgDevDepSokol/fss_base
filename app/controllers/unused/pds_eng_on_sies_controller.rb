class PdsEngOnSiesController < ApplicationController
  before_action :set_pds_eng_on_sy, only: [:show, :edit, :update, :destroy]

  # GET /pds_eng_on_sies
  # GET /pds_eng_on_sies.json
  def index
    @pds_eng_on_sies = PdsEngOnSy.all
  end

  # GET /pds_eng_on_sies/1
  # GET /pds_eng_on_sies/1.json
  def show
  end

  # GET /pds_eng_on_sies/new
  def new
    @pds_eng_on_sy = PdsEngOnSy.new
  end

  # GET /pds_eng_on_sies/1/edit
  def edit
  end

  # POST /pds_eng_on_sies
  # POST /pds_eng_on_sies.json
  def create
    @pds_eng_on_sy = PdsEngOnSy.new(pds_eng_on_sy_params)

    respond_to do |format|
      if @pds_eng_on_sy.save
        format.html { redirect_to @pds_eng_on_sy, notice: 'Pds eng on sy was successfully created.' }
        format.json { render :show, status: :created, location: @pds_eng_on_sy }
      else
        format.html { render :new }
        format.json { render json: @pds_eng_on_sy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_eng_on_sies/1
  # PATCH/PUT /pds_eng_on_sies/1.json
  def update
    respond_to do |format|
      if @pds_eng_on_sy.update(pds_eng_on_sy_params)
        format.html { redirect_to @pds_eng_on_sy, notice: 'Pds eng on sy was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_eng_on_sy }
      else
        format.html { render :edit }
        format.json { render json: @pds_eng_on_sy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_eng_on_sies/1
  # DELETE /pds_eng_on_sies/1.json
  def destroy
    @pds_eng_on_sy.destroy
    respond_to do |format|
      format.html { redirect_to pds_eng_on_sies_url, notice: 'Pds eng on sy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_eng_on_sy
      @pds_eng_on_sy = PdsEngOnSy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_eng_on_sy_params
      params.require(:pds_eng_on_sy).permit(:sys, :Project, :engineer_N, :t, :TestOperator_N)
    end
end
