class PdsButtonsController < ApplicationController
  before_action :set_pds_button, only: [:show, :edit, :update, :destroy]

  # GET /pds_buttons
  # GET /pds_buttons.json
  def index
    @pds_buttons_grid = initialize_grid(PdsButton)
    @pds_buttons = PdsButton.all
  end

  # GET /pds_buttons/1
  # GET /pds_buttons/1.json
  def show
  end

  # GET /pds_buttons/new
  def new
    @pds_button = PdsButton.new
  end

  # GET /pds_buttons/1/edit
  def edit
  end

  # POST /pds_buttons
  # POST /pds_buttons.json
  def create
    @pds_button = PdsButton.new(pds_button_params)

    respond_to do |format|
      if @pds_button.save
        format.html { redirect_to @pds_button, notice: 'Pds button was successfully created.' }
        format.json { render :show, status: :created, location: @pds_button }
      else
        format.html { render :new }
        format.json { render json: @pds_button.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_buttons/1
  # PATCH/PUT /pds_buttons/1.json
  def update
    respond_to do |format|
      if @pds_button.update(pds_button_params)
        format.html { redirect_to @pds_button, notice: 'Pds button was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_button }
      else
        format.html { render :edit }
        format.json { render json: @pds_button.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_buttons/1
  # DELETE /pds_buttons/1.json
  def destroy
    @pds_button.destroy
    respond_to do |format|
      format.html { redirect_to pds_buttons_url, notice: 'Pds button was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_button
      @pds_button = PdsButton.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_button_params
      params.require(:pds_button).permit(:IC, :sys, :Project, :range, :Fixed, :t)
    end
end
