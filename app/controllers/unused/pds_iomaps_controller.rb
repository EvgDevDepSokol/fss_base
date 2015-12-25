class PdsIomapsController < ApplicationController
  before_action :set_pds_iomap, only: [:show, :edit, :update, :destroy]

  # GET /pds_iomaps
  # GET /pds_iomaps.json
  def index
    @pds_iomaps = PdsIomap.all
  end

  # GET /pds_iomaps/1
  # GET /pds_iomaps/1.json
  def show
  end

  # GET /pds_iomaps/new
  def new
    @pds_iomap = PdsIomap.new
  end

  # GET /pds_iomaps/1/edit
  def edit
  end

  # POST /pds_iomaps
  # POST /pds_iomaps.json
  def create
    @pds_iomap = PdsIomap.new(pds_iomap_params)

    respond_to do |format|
      if @pds_iomap.save
        format.html { redirect_to @pds_iomap, notice: 'Pds iomap was successfully created.' }
        format.json { render :show, status: :created, location: @pds_iomap }
      else
        format.html { render :new }
        format.json { render json: @pds_iomap.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_iomaps/1
  # PATCH/PUT /pds_iomaps/1.json
  def update
    respond_to do |format|
      if @pds_iomap.update(pds_iomap_params)
        format.html { redirect_to @pds_iomap, notice: 'Pds iomap was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_iomap }
      else
        format.html { render :edit }
        format.json { render json: @pds_iomap.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_iomaps/1
  # DELETE /pds_iomaps/1.json
  def destroy
    @pds_iomap.destroy
    respond_to do |format|
      format.html { redirect_to pds_iomaps_url, notice: 'Pds iomap was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_iomap
      @pds_iomap = PdsIomap.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_iomap_params
      params.require(:pds_iomap).permit(:Project, :hwaddress, :io_point_name, :number_of_array_elem, :sid, :comp_name, :remark, :t)
    end
end
