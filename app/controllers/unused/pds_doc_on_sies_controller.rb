class PdsDocOnSiesController < ApplicationController
  before_action :set_pds_doc_on_sy, only: [:show, :edit, :update, :destroy]

  # GET /pds_doc_on_sies
  # GET /pds_doc_on_sies.json
  def index
    @pds_doc_on_sies = PdsDocOnSy.all
  end

  # GET /pds_doc_on_sies/1
  # GET /pds_doc_on_sies/1.json
  def show
  end

  # GET /pds_doc_on_sies/new
  def new
    @pds_doc_on_sy = PdsDocOnSy.new
  end

  # GET /pds_doc_on_sies/1/edit
  def edit
  end

  # POST /pds_doc_on_sies
  # POST /pds_doc_on_sies.json
  def create
    @pds_doc_on_sy = PdsDocOnSy.new(pds_doc_on_sy_params)

    respond_to do |format|
      if @pds_doc_on_sy.save
        format.html { redirect_to @pds_doc_on_sy, notice: 'Pds doc on sy was successfully created.' }
        format.json { render :show, status: :created, location: @pds_doc_on_sy }
      else
        format.html { render :new }
        format.json { render json: @pds_doc_on_sy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_doc_on_sies/1
  # PATCH/PUT /pds_doc_on_sies/1.json
  def update
    respond_to do |format|
      if @pds_doc_on_sy.update(pds_doc_on_sy_params)
        format.html { redirect_to @pds_doc_on_sy, notice: 'Pds doc on sy was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_doc_on_sy }
      else
        format.html { render :edit }
        format.json { render json: @pds_doc_on_sy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_doc_on_sies/1
  # DELETE /pds_doc_on_sies/1.json
  def destroy
    @pds_doc_on_sy.destroy
    respond_to do |format|
      format.html { redirect_to pds_doc_on_sies_url, notice: 'Pds doc on sy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_doc_on_sy
      @pds_doc_on_sy = PdsDocOnSy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_doc_on_sy_params
      params.require(:pds_doc_on_sy).permit(:Doc, :sys, :t)
    end
end
