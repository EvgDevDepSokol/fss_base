class Api::PdsSectionAssemblersController < ApplicationController
  before_action :set_pds_section_assembler, only: [:show, :edit, :update, :destroy]
  before_action :project, only: :index

  # GET /pds_section_assemblers
  # GET /pds_section_assemblers.json
  def index
    @pds_section_assemblers = PdsSectionAssembler.where(Project: project.ProjectID)
  end

  # GET /pds_section_assemblers/1
  # GET /pds_section_assemblers/1.json
  def show
  end

  # GET /pds_section_assemblers/new
  def new
    @pds_section_assembler = PdsSectionAssembler.new
  end

  # GET /pds_section_assemblers/1/edit
  def edit
  end

  # POST /pds_section_assemblers
  # POST /pds_section_assemblers.json
  def create
    @pds_section_assembler = PdsSectionAssembler.new(pds_section_assembler_params)

    respond_to do |format|
      if @pds_section_assembler.save
        format.html { redirect_to @pds_section_assembler, notice: 'Pds section assembler was successfully created.' }
        format.json { render :show, status: :created, location: @pds_section_assembler }
      else
        format.html { render :new }
        format.json { render json: @pds_section_assembler.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_section_assemblers/1
  # PATCH/PUT /pds_section_assemblers/1.json
  def update
    respond_to do |format|
      if @pds_section_assembler.update(pds_section_assembler_params)
        format.html { redirect_to @pds_section_assembler, notice: 'Pds section assembler was successfully updated.' }
        format.json { render :show, status: :ok, location: @pds_section_assembler }
      else
        format.html { render :edit }
        format.json { render json: @pds_section_assembler.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pds_section_assemblers/1
  # DELETE /pds_section_assemblers/1.json
  def destroy
    @pds_section_assembler.destroy
    respond_to do |format|
      format.html { redirect_to pds_section_assemblers_url, notice: 'Pds section assembler was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_pds_section_assembler
    @pds_section_assembler = PdsSectionAssembler.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pds_section_assembler_params
    params.require(:pds_section_assembler).permit(:Project, :section_name, :assembler, :t, :assembler_pwr, :assembler_ec)
  end

  def project
    @project ||= PdsProject.find_by(ProjectID: params[:pds_project_id])
  end
end
