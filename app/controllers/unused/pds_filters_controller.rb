class PdsFiltersController < ApplicationController
  before_action :set_pds_filter, only: [:show, :edit, :update, :destroy]

  # GET /pds_filters
  # GET /pds_filters.json
  def index
    @pds_filters = PdsFilter.all
  end

  # GET /pds_filters/1
  # GET /pds_filters/1.json
  def show
  end

  # GET /pds_filters/new
  def new
    @pds_filter = PdsFilter.new
  end

  # GET /pds_filters/1/edit
  def edit
  end

  # POST /pds_filters
  # POST /pds_filters.json
  def create
    @pds_filter = PdsFilter.new(pds_filter_params)

    respond_to do |format|
      if @pds_filter.save
        format.html { redirect_to @pds_filter, notice: 'Pds filter was successfully created.' }
        format.json { render :show, status: :created, location: @pds_filter }
      else
        format.html { render :new }
        format.json { render json: @pds_filter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_filters/1
  # PATCH/PUT /pds_filters/1.json
  def update
    respond_to do |format|
      if @pds_filter.update(pds_filter_params)
        format.html { redirect_to @pds_filter, notice: 'Pds filter was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_filter }
      else
        format.html { render :edit }
        format.json { render json: @pds_filter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_filters/1
  # DELETE /pds_filters/1.json
  def destroy
    @pds_filter.destroy
    respond_to do |format|
      format.html { redirect_to pds_filters_url, notice: 'Pds filter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_filter
      @pds_filter = PdsFilter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_filter_params
      params.require(:pds_filter).permit(:kks, :ShortDesc, :Desc_EN, :level, :room, :Project, :sys, :eq_type, :var, :old_var, :sd_N)
    end
end
