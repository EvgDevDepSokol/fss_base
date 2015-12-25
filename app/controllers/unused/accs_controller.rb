class AccsController < ApplicationController
  before_action :set_acc, only: [:show, :edit, :update, :destroy]

  # GET /accs
  # GET /accs.json
  def index
    @accs = Acc.all
  end

  # GET /accs/1
  # GET /accs/1.json
  def show
  end

  # GET /accs/new
  def new
    @acc = Acc.new
  end

  # GET /accs/1/edit
  def edit
  end

  # POST /accs
  # POST /accs.json
  def create
    @acc = Acc.new(acc_params)

    respond_to do |format|
      if @acc.save
        format.html { redirect_to @acc, notice: 'Acc was successfully created.' }
        format.json { render :show, status: :created, location: @acc }
      else
        format.html { render :new }
        format.json { render json: @acc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accs/1
  # PATCH/PUT /accs/1.json
  def update
    respond_to do |format|
      if @acc.update(acc_params)
        format.html { redirect_to @acc, notice: 'Acc was successfully updated.' }
        format.json { render :show, status: :ok, location: @acc }
      else
        format.html { render :edit }
        format.json { render json: @acc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accs/1
  # DELETE /accs/1.json
  def destroy
    @acc.destroy
    respond_to do |format|
      format.html { redirect_to accs_url, notice: 'Acc was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_acc
      @acc = Acc.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def acc_params
      params.require(:acc).permit(:Project, :ped, :Name, :number, :SH, :SV, :tag_no, :store, :scale_min, :scale_max, :Unit, :MP_CMEMO, :pa)
    end
end
