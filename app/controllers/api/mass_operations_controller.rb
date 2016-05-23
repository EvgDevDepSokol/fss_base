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
      lpass=false 
      column = params[:column]
      querry = querry.find(params[:ids])
      querry.each do |row|
        val = row.send(column)
        if (val.nil?||(val==''))
          if ((params[:from].nil?)||(params[:from]==''))
            row.send(column+'=', params[:to])
            row.save
            lpass=true
          end
        elsif val.is_a? Fixnum # selector 
          if val == params[:from].to_i
            row.send(column+'=', params[:to].to_i)
            row.save 
            lpass=true
          end
        elsif val.is_a? String # string or textEditor
          if ((params[:from].nil?)||(params[:from]==''))
            if row[column]==params[:from]
              row[column]=params[:to]
              row.save
              lpass=true
            end
          elsif row[column].include? params[:from]
            row[column].gsub!(params[:from],params[:to]) 
            row.save
            lpass=true
          end
        elsif val.is_a? Float # string or textEditor, when value is float
          valfrom=(Float(params[:from]) rescue nil)
          valto=(Float(params[:to]) rescue nil)
          if Float(row[column])==valfrom
            row[column]=valto
            row.save
            lpass=true
          end
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
