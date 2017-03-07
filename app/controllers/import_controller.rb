class ImportController < ApplicationController
  include GeneralControllerHelper

  before_action :project, :key_column
  helper_method :project, :key_column

  def update_all
    message = []
    params[:data].each do |_i, row|
      if !!current_object(row[@key_column])
        permit_params(row)
        if @current_object.update(@permitted)
          message.push(row[@key_column] + ' updated successfully!')
        else
          message.push(row[@key_column] + ' has some wrong parameters:' + current_object.errors)
        end
      else
        message.push(row[@key_column] + ' does not exist!')
      end
    end
    render json: { status: :ok, message: message}
  rescue
    render json: { status: :unprocessable_entity, message: message}
  end

  private

  def current_object(val)
    @current_object = model.find_by(@key_column => val, Project: @project)
  end

  def key_column
    @key_column = (params[:keyColumn] if params[:keyColumn])
  end

  def project
    @project ||= PdsProject.find(params[:pds_project_id]) if params[:pds_project_id]
  end

  def permit_params(row)
    @permitted = row.permit!
  end

  def table_data
    if model_class.method_defined? :custom_hash
      @data_list.map(&:custom_hash).to_json
    else
      @data_list.to_json
    end
  end
end
