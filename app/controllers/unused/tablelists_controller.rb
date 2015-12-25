class TablelistsController < ApplicationController
  before_action :set_tablelist, only: [:show, :edit, :update, :destroy]

  # GET /tablelists
  # GET /tablelists.json
  def index
    @tablelists = Tablelist.all
  end

  # GET /tablelists/1
  # GET /tablelists/1.json
  def show
  end

  # GET /tablelists/new
  def new
    @tablelist = Tablelist.new
  end

  # GET /tablelists/1/edit
  def edit
  end

  # POST /tablelists
  # POST /tablelists.json
  def create
    @tablelist = Tablelist.new(tablelist_params)

    respond_to do |format|
      if @tablelist.save
        format.html { redirect_to @tablelist, notice: 'Tablelist was successfully created.' }
        format.json { render :show, status: :created, location: @tablelist }
      else
        format.html { render :new }
        format.json { render json: @tablelist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tablelists/1
  # PATCH/PUT /tablelists/1.json
  def update
    respond_to do |format|
      if @tablelist.update(tablelist_params)
        format.html { redirect_to @tablelist, notice: 'Tablelist was successfully updated.' }
        format.json { render :show, status: :ok, location: @tablelist }
      else
        format.html { render :edit }
        format.json { render json: @tablelist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tablelists/1
  # DELETE /tablelists/1.json
  def destroy
    @tablelist.destroy
    respond_to do |format|
      format.html { redirect_to tablelists_url, notice: 'Tablelist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tablelist
      @tablelist = Tablelist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tablelist_params
      params.require(:tablelist).permit(:table, :title, :Desc, :BlobObj, :number)
    end
end
