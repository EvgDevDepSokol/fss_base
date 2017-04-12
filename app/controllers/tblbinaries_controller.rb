class TblbinariesController < ApplicationController
  # Tblbinaries controller
  before_action :set_tblbinary, only: %i[show edit update destroy]
  # GET /tblbinaries
  # GET /tblbinaries.json
  def index
    @tblbinaries = Tblbinary.all
  end

  # GET /tblbinaries/1
  # GET /tblbinaries/1.json
  def show; end

  # GET /tblbinaries/new
  def new
    @tblbinary = Tblbinary.new
  end

  # GET /tblbinaries/1/edit
  def edit; end

  # ('<img src="data:image/jpg;base64,%s">' % Base64.encode64(@the_data)).html_safe
  def get_file
    File.open('public/tmp/tempimg.tiff', 'w') do |f|
      f.write(@tblbinary.binObj.force_encoding('UTF-8'))
    end

    image = MiniMagick::Image.read(@tblbinary.binObj.force_encoding('UTF-8'))
    # image.path #=> "/var/folders/k7/6zx6dx6x7ys3rv3srh0nyfj00000gn/T/magick20140921-75881-1yho3zc.jpg"
    # image.resize "100x100"
    image.format 'png'
    # image.write "output.png"

    send_data image.to_blob, type: 'image/png', disposition: 'inline'
    #    send_data TRANSPARENT_GIF, :type => 'image/gif', :disposition => 'inline'
  end

  # POST /tblbinaries
  # POST /tblbinaries.json
  def create
    @tblbinary = Tblbinary.new(tblbinary_params)

    respond_to do |format|
      if @tblbinary.save
        format.html { redirect_to @tblbinary, notice: 'Tblbinary was successfully created.' }
        format.json { render :show, status: :created, location: @tblbinary }
      else
        format.html { render :new }
        format.json { render json: @tblbinary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tblbinaries/1
  # PATCH/PUT /tblbinaries/1.json
  def update
    respond_to do |format|
      if @tblbinary.update(tblbinary_params)
        format.html { redirect_to @tblbinary, notice: 'Tblbinary was successfully updated.' }
        format.json { render :show, status: :ok, location: @tblbinary }
      else
        format.html { render :edit }
        format.json { render json: @tblbinary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tblbinaries/1
  # DELETE /tblbinaries/1.json
  def destroy
    @tblbinary.destroy
    respond_to do |format|
      format.html { redirect_to tblbinaries_url, notice: 'Tblbinary was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tblbinary
    @tblbinary = Tblbinary.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def tblbinary_params
    params.require(:tblbinary).permit(:Title, :Type, :Length, :binObj, :t)
  end
end
