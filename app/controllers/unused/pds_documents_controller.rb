class PdsDocumentsController < ApplicationController
  before_action :set_pds_document, only: [:show, :edit, :update, :destroy]

  # GET /pds_documents
  # GET /pds_documents.json
  def index
    @pds_documents = PdsDocument.all
  end

  # GET /pds_documents/1
  # GET /pds_documents/1.json
  def show
  end

  # GET /pds_documents/new
  def new
    @pds_document = PdsDocument.new
  end

  # GET /pds_documents/1/edit
  def edit
  end

  # POST /pds_documents
  # POST /pds_documents.json
  def create
    @pds_document = PdsDocument.new(pds_document_params)

    respond_to do |format|
      if @pds_document.save
        format.html { redirect_to @pds_document, notice: 'Pds document was successfully created.' }
        format.json { render :show, status: :created, location: @pds_document }
      else
        format.html { render :new }
        format.json { render json: @pds_document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_documents/1
  # PATCH/PUT /pds_documents/1.json
  def update
    respond_to do |format|
      if @pds_document.update(pds_document_params)
        format.html { redirect_to @pds_document, notice: 'Pds document was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_document }
      else
        format.html { render :edit }
        format.json { render json: @pds_document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_documents/1
  # DELETE /pds_documents/1.json
  def destroy
    @pds_document.destroy
    respond_to do |format|
      format.html { redirect_to pds_documents_url, notice: 'Pds document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pds_document
      @pds_document = PdsDocument.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pds_document_params
      params.require(:pds_document).permit(:DocTitle, :Code, :Author, :Project, :FileRu, :FileEn, :CheckOutRu, :t, :CheckOutEn)
    end
end
