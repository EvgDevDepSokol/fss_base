class HwIosignaldimsController < ApplicationController
  before_action :set_hw_iosignaldim, only: [:show, :edit, :update, :destroy]

  # GET /hw_iosignaldims
  # GET /hw_iosignaldims.json
  def index
    @hw_iosignaldims = HwIosignaldim.all
  end

  # GET /hw_iosignaldims/1
  # GET /hw_iosignaldims/1.json
  def show
  end

  # GET /hw_iosignaldims/new
  def new
    @hw_iosignaldim = HwIosignaldim.new
  end

  # GET /hw_iosignaldims/1/edit
  def edit
  end

  # POST /hw_iosignaldims
  # POST /hw_iosignaldims.json
  def create
    @hw_iosignaldim = HwIosignaldim.new(hw_iosignaldim_params)

    respond_to do |format|
      if @hw_iosignaldim.save
        format.html { redirect_to @hw_iosignaldim, notice: 'Hw iosignaldim was successfully created.' }
        format.json { render :show, status: :created, location: @hw_iosignaldim }
      else
        format.html { render :new }
        format.json { render json: @hw_iosignaldim.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hw_iosignaldims/1
  # PATCH/PUT /hw_iosignaldims/1.json
  def update
    respond_to do |format|
      if @hw_iosignaldim.update(hw_iosignaldim_params)
        format.html { redirect_to @hw_iosignaldim, notice: 'Hw iosignaldim was successfully updated.' }
        format.json { render :show, status: :ok, location: @hw_iosignaldim }
      else
        format.html { render :edit }
        format.json { render json: @hw_iosignaldim.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hw_iosignaldims/1
  # DELETE /hw_iosignaldims/1.json
  def destroy
    @hw_iosignaldim.destroy
    respond_to do |format|
      format.html { redirect_to hw_iosignaldims_url, notice: 'Hw iosignaldim was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hw_iosignaldim
      @hw_iosignaldim = HwIosignaldim.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hw_iosignaldim_params
      params.require(:hw_iosignaldim).permit(:Project, :signID, :num, :type, :suff)
    end
end
