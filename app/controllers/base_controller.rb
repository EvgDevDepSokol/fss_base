class BaseController < ApplicationController
  include GeneralControllerHelper

  layout 'layouts/table'

  before_action :project
  helper_method :project, :table_data
  def create
    Rails.logger.warn permit_params
    @current_object = model_class.new permit_params
    if @current_object.save permit_params
      render json: { status: :created, data: current_object.reload.custom_hash }
    else
      render json: { errors: @current_object.errors.full_messages}, status: :unprocessable_entity 
      Rails.logger.info(@current_object.errors.full_messages)
    end
  end

  def update
    Rails.logger.warn permit_params
    if current_object.update permit_params
      render json: { status: :ok, data: current_object.custom_hash }
    else
      render json: { errors: current_object.errors.full_messages, data: current_object.reload.custom_hash },
             status: :unprocessable_entity
      Rails.logger.info(@current_object.errors.full_messages)
    end

    rescue
      render json: { errors: current_object.errors.full_messages, data: current_object.reload.custom_hash },
             status: :unprocessable_entity
      Rails.logger.info(@current_object.errors.full_messages)
    end

  def destroy
    if current_object.destroy
      render json: {}, head: :no_content
    else
      render json: { errors: current_object.errors.full_messages }, status: 403
    end
  end

  private

  def current_object
    @current_object ||= model.find(params[:id])
  end

  def project
    @project ||= PdsProject.find(params[:pds_project_id]) if params[:pds_project_id]
  end

  def permit_params
    if (!model.attribute_names.include? 'Project') && params[model.to_s.underscore].key?('Project')
      params[model.to_s.underscore].delete :Project
    end
    params.require(model.to_s.underscore).permit!
  end

  # Oj.default_options = { :mode => :null }
  def table_data
    Oj.default_options = { mode: :compat }
    if (model_class.method_defined? :custom_hash) && (!model_class.method_defined? :custom_map)
      Oj.dump(@data_list.map(&:custom_hash))
      # @data_list.map{ |e| e.custom_hash }.to_json
    else
      Oj.dump(@data_list)
      # @data_list.to_json
    end
  end
end
