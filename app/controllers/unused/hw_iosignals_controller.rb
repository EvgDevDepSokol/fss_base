class HwIosignalsController < ApplicationController
  before_action :set_hw_iosignal, only: [:show, :edit, :update, :destroy]

  # GET /hw_iosignals
  # GET /hw_iosignals.json
  def index
    @hw_iosignals = HwIosignal.all
  end

  # GET /hw_iosignals/1
  # GET /hw_iosignals/1.json
  def show
  end

  # GET /hw_iosignals/new
  def new
    @hw_iosignal = HwIosignal.new
  end

  # GET /hw_iosignals/1/edit
  def edit
  end

  # POST /hw_iosignals
  # POST /hw_iosignals.json
  def create
    @hw_iosignal = HwIosignal.new(hw_iosignal_params)

    respond_to do |format|
      if @hw_iosignal.save
        format.html { redirect_to @hw_iosignal, notice: 'Hw iosignal was successfully created.' }
        format.json { render :show, status: :created, location: @hw_iosignal }
      else
        format.html { render :new }
        format.json { render json: @hw_iosignal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hw_iosignals/1
  # PATCH/PUT /hw_iosignals/1.json
  def update
    respond_to do |format|
      if @hw_iosignal.update(hw_iosignal_params)
        format.html { redirect_to @hw_iosignal, notice: 'Hw iosignal was successfully updated.' }
        format.json { render :show, status: :ok, location: @hw_iosignal }
      else
        format.html { render :edit }
        format.json { render json: @hw_iosignal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hw_iosignals/1
  # DELETE /hw_iosignals/1.json
  def destroy
    @hw_iosignal.destroy
    respond_to do |format|
      format.html { redirect_to hw_iosignals_url, notice: 'Hw iosignal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hw_iosignal
      @hw_iosignal = HwIosignal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hw_iosignal_params
      params.require(:hw_iosignal).permit(:Project, :pedID, :signID, :wirecode, :contact, :sw_pref, :sw_suff, :hw_suff, :comment, :contactnum, :description, :diapason, :limits, :t, :temp)
    end
end
