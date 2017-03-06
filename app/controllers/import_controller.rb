class ImportController < ApplicationController
  include GeneralControllerHelper

  before_action :project, :key_column
  helper_method :project, :key_column, :key_column_val

  def update_all
    #@key_name = model.primary_key
    params[:data].each do |i,row|
      byebug
      #@key_val = row[1][@key_column]
      #@ind = row[0]
      #logger.debug "@key_name                 : #{@key_name}"
      #logger.debug "@key_val                  : #{@key_val}"
      #logger.debug "@ind                      : #{@ind}"
      #logger.debug "row[1]                    : #{row[1]}"
      #logger.debug "current_object            : #{current_object}"
      #logger.debug "current_object.custom_hash: #{current_object.custom_hash}"
      if current_object(row[@key_column]).update(permit_params(row))
        logger.debug 'ok'
      #        render json: {status: :ok } # , data: current_object.custom_hash}
      else
        logger.warning 'Error'
        #        render json: {errors: current_object.errors, data: current_object.reload.custom_hash},
        #          status: :unprocessable_entity
      end
    end
    render json: { status: :ok }
    rescue
      logger.error 'Import_all Rescue'
      #    render json: {(errors: current_object.errors , data: current_object.reload.custom_hash})if current_object,
      render json: { status: :unprocessable_entity }
    end

  private

  def current_object(val)
    #@current_object = model.where({@key_column=>val,Project:@project})
    byebug
    @current_object = model.find_by({@key_column=>val,Project:@project})
  end

  def key_column
    @key_column = (params[:keyColumn] if params[:keyColumn])
  end

  def project
    @project ||= PdsProject.find(params[:pds_project_id]) if params[:pds_project_id]
  end

  def permit_params(row)
    byebug
    params[model.to_s.underscore] = row #params[:data][@ind]
    params.require(model.to_s.underscore).permit!
  end

  def table_data
    if model_class.method_defined? :custom_hash
      @data_list.map(&:custom_hash).to_json
    else
      @data_list.to_json
    end
  end
end
