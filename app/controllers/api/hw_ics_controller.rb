class Api::HwIcsController < ApplicationController
  include GeneralControllerHelper
  require 'csv'

  before_action :project, only: :index

  def index
    @hw_ics = HwIc.select(:icID, :ref).where(Project: project.ProjectID).order(:ref)
    respond_to do |format|
      format.html { render index_view }
      format.csv
      format.xlsx
      format.json
    end
  end

  # GET /pds_buttons/1
  # GET /pds_buttons/1.json
  def show; end

  private

  def project
    @project ||= PdsProject.find_by(ProjectID: params[:pds_project_id])
  end
end
