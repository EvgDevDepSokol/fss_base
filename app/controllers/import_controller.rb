class ImportController < ApplicationController

  include GeneralControllerHelper

  def update_all
    params[:data].each do |row|
      Rails.logger.warn row.as_json
    end
    if current_object.update permit_params

      render json: {status: :ok, data: current_object.custom_hash}
    else
      render json: {errors: current_object.errors, data: current_object.reload.custom_hash},
        status: :unprocessable_entity
    end

  rescue
    render json: {errors: current_object.errors, data: current_object.reload.custom_hash},
      status: :unprocessable_entity
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

  def table_data
    if model_class.method_defined? :custom_hash
      @data_list.map{ |e| e.custom_hash }.to_json
    else
      @data_list.to_json
    end
  end

end