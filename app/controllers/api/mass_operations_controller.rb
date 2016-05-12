class Api::MassOperationsController < ApplicationController
  include GeneralControllerHelper

  def update_all
    return unless params[:column] || params[:from] || params[:to]
    querry = model_class

    if querry.respond_to?(:Project)
      querry = querry.where(Project: project.id) if project 
    end

    # querry = querry.where(id: params[:ids]) if params[:ids]

    if params[:ids] 
      p querry
      querry = querry.find(params[:ids])
      # querry = querry.where("? in (?)",querry.primary_key, params[:ids])
      p querry
  
      querry.each do |row|
        if row[params[:column]].include? params[:from]
          row[params[:column]].gsub!(params[:from],params[:to])
          row.save
        end
      end
    
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
