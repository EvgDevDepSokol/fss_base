class Api::MassOperationsController < ApplicationController
  include GeneralControllerHelper

  def update_all
    return unless params[:column] || params[:from] || params[:to]
    querry = model_class

    querry = querry.where(Project: project.id) if project

    if params[:from] != '*'
      querry = querry.where(params[:column] => params[:from])
    end

    querry = querry.where(id: params[:ids]) if params[:ids]

    if querry.update_all(params[:column] => params[:to])
      render json: { status: :ok }
    else
      render json: { status: :error }
    end
  end

  private

  def project
    @project ||= PdsProject.find(params[:pds_project_id]) if params[:pds_project_id]
  end
end
