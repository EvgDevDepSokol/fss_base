class HwWirelistsController < ApplicationController
  before_action :set_hw_wirelist, only: [:show, :edit, :update, :destroy]

  # GET /hw_wirelists
  # GET /hw_wirelists.json
  def index
    @hw_wirelists = HwWirelist.all
  end

  # GET /hw_wirelists/1
  # GET /hw_wirelists/1.json
  def show
  end

  # GET /hw_wirelists/new
  def new
    @hw_wirelist = HwWirelist.new
  end

  # GET /hw_wirelists/1/edit
  def edit
  end

  # POST /hw_wirelists
  # POST /hw_wirelists.json
  def create
    @hw_wirelist = HwWirelist.new(hw_wirelist_params)

    respond_to do |format|
      if @hw_wirelist.save
        format.html { redirect_to @hw_wirelist, notice: 'Hw wirelist was successfully created.' }
        format.json { render :show, status: :created, location: @hw_wirelist }
      else
        format.html { render :new }
        format.json { render json: @hw_wirelist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hw_wirelists/1
  # PATCH/PUT /hw_wirelists/1.json
  def update
    respond_to do |format|
      if @hw_wirelist.update(hw_wirelist_params)
        format.html { redirect_to @hw_wirelist, notice: 'Hw wirelist was successfully updated.' }
        format.json { render :show, status: :ok, location: @hw_wirelist }
      else
        format.html { render :edit }
        format.json { render json: @hw_wirelist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hw_wirelists/1
  # DELETE /hw_wirelists/1.json
  def destroy
    @hw_wirelist.destroy
    respond_to do |format|
      format.html { redirect_to hw_wirelists_url, notice: 'Hw wirelist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hw_wirelist
      @hw_wirelist = HwWirelist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hw_wirelist_params
      params.require(:hw_wirelist).permit(:from, :to, :wc, :nc, :io, :m, :s, :word, :bit, :power, :origin, :net, :ped, :Project, :rev, :Unit, :step, :t, :IC, :remarks, :io_signalID, :panel, :pds_mark)
    end
end
