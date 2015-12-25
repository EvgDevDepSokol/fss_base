class SignRptsController < ApplicationController
  before_action :set_sign_rpt, only: [:show, :edit, :update, :destroy]

  # GET /sign_rpts
  # GET /sign_rpts.json
  def index
    @sign_rpts = SignRpt.all
  end

  # GET /sign_rpts/1
  # GET /sign_rpts/1.json
  def show
  end

  # GET /sign_rpts/new
  def new
    @sign_rpt = SignRpt.new
  end

  # GET /sign_rpts/1/edit
  def edit
  end

  # POST /sign_rpts
  # POST /sign_rpts.json
  def create
    @sign_rpt = SignRpt.new(sign_rpt_params)

    respond_to do |format|
      if @sign_rpt.save
        format.html { redirect_to @sign_rpt, notice: 'Sign rpt was successfully created.' }
        format.json { render :show, status: :created, location: @sign_rpt }
      else
        format.html { render :new }
        format.json { render json: @sign_rpt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sign_rpts/1
  # PATCH/PUT /sign_rpts/1.json
  def update
    respond_to do |format|
      if @sign_rpt.update(sign_rpt_params)
        format.html { redirect_to @sign_rpt, notice: 'Sign rpt was successfully updated.' }
        format.json { render :show, status: :ok, location: @sign_rpt }
      else
        format.html { render :edit }
        format.json { render json: @sign_rpt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sign_rpts/1
  # DELETE /sign_rpts/1.json
  def destroy
    @sign_rpt.destroy
    respond_to do |format|
      format.html { redirect_to sign_rpts_url, notice: 'Sign rpt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sign_rpt
      @sign_rpt = SignRpt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sign_rpt_params
      params.require(:sign_rpt).permit(:engID, :engName, :BlobObj)
    end
end
