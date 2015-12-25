class PdsBlocksController < ApplicationController
  before_action :set_pds_block, only: [:show, :edit, :update, :destroy]

  # GET /pds_blocks
  # GET /pds_blocks.json
  def index
    @pds_blocks = PdsBlock.all
  end

  # GET /pds_blocks/1
  # GET /pds_blocks/1.json
  def show
  end

  # GET /pds_blocks/new
  def new
    @pds_block = PdsBlock.new
  end

  # GET /pds_blocks/1/edit
  def edit
  end

  # POST /pds_blocks
  # POST /pds_blocks.json
  def create
    @pds_block = PdsBlock.new(pds_block_params)

    respond_to do |format|
      if @pds_block.save
        format.html { redirect_to @pds_block, notice: 'Pds block was successfully created.' }
        format.json { render :show, status: :created, location: @pds_block }
      else
        format.html { render :new }
        format.json { render json: @pds_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_blocks/1
  # PATCH/PUT /pds_blocks/1.json
  def update
    respond_to do |format|
      if @pds_block.update(pds_block_params)
        format.html { redirect_to @pds_block, notice: 'Pds block was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_block }
      else
        format.html { render :edit }
        format.json { render json: @pds_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_blocks/1
  # DELETE /pds_blocks/1.json
  def destroy
    @pds_block.destroy
    respond_to do |format|
      format.html { redirect_to pds_blocks_url, notice: 'Pds block was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_block
      @pds_block = PdsBlock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_block_params
      params.require(:pds_block).permit(:sys, :p_p, :Desc, :doc, :varName, :Project)
    end
end
