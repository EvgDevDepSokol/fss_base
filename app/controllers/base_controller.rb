class BaseController < ApplicationController
  # Base controller, methods for all models defined here
  include GeneralControllerHelper

  layout 'layouts/table'

  before_action :project
  helper_method :project, :table_data
  def create
    extra_extract
    @current_object = model_class.new permit_params
    if @current_object.save permit_params
      render json: { status: :created, data: data }
    else
      render json: { errors: @current_object.errors.full_messages }, status: :unprocessable_entity
      Rails.logger.info(@current_object.errors.full_messages)
    end
  end

  def update
    extra_extract
    if !params[model.to_s.underscore].present?
      render json: { status: :ok, data: data }
    elsif current_object.update permit_params
      render json: { status: :ok, data: data }
    else
      render json: { errors: current_object.errors.full_messages, data: data },
             status: :unprocessable_entity
      Rails.logger.info(@current_object.errors.full_messages)
    end
    rescue StandardError
      render json: { errors: current_object.errors.full_messages, data: data },
             status: :unprocessable_entity
      Rails.logger.info(@current_object.errors.full_messages)
    end

  def destroy
    if current_object.destroy
      render json: {}, head: :no_content
    else
      render json: { errors: current_object.errors.full_messages }, status: 403
      Rails.logger.info(@current_object.errors.full_messages)
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
    params.require(model.to_s.underscore).permit!
  end

  # Oj.default_options = { :mode => :null }
  def table_data
    Oj.default_options = { mode: :compat }
    if (model_class.method_defined? :custom_hash) && (!model_class.respond_to? :plucked)
      Oj.dump(@data_list.map(&:custom_hash))
    else
      Oj.dump(@data_list)
    end
  end

  def extra_extract
    if (!model.attribute_names.include? 'Project') && params[model.to_s.underscore].key?('Project')
      params[model.to_s.underscore].delete :Project
    end
    if params[model.to_s.underscore].key?('extra_data')
      @extra_extract = params[model.to_s.underscore]['extra_data']
      params[model.to_s.underscore].delete :extra_data
    end
    params[model.to_s.underscore].delete :extra_label if params[model.to_s.underscore].key?('extra_label')
  end

  def extra_inject
    if model_class.respond_to? :extra_actions
      model.extra_actions(current_object.id, @extra_extract)
    else
      {}
    end
  end

  def data
    data = current_object.reload.custom_hash
    data_in = extra_inject
    data.merge(data_in)
  end
end
