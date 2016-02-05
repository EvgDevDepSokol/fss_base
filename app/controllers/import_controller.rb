class ImportController < ApplicationController

  include GeneralControllerHelper
  def update_all
#    byebug
    @key_name=model.primary_key
    params[:data].each do |row|
      @key_val=row[1][@key_name]
      @ind=row[0]
      logger.debug "@key_name                 : #{@key_name}"
      logger.debug "@key_val                  : #{@key_val10}"
      logger.debug "@ind                      : #{@ind}"
      logger.debug "row[1]                    : #{row[1]}"
      logger.debug "current_object            : #{current_object}"
      logger.debug "current_object.custom_hash: #{current_object.custom_hash}"

      if current_object.update(permit_params)
        logger.debug "ok"
#        render json: {status: :ok } # , data: current_object.custom_hash}
      else
        logger.warning "Error"
#        render json: {errors: current_object.errors, data: current_object.reload.custom_hash},
#          status: :unprocessable_entity
      end
    end
    render json: {status: :ok}
  rescue
    logger.error "Import_all Rescue"
#    render json: {(errors: current_object.errors , data: current_object.reload.custom_hash})if current_object,
    render json:{status: :unprocessable_entity}
  end

  private
  def current_object
    @current_object = (model.find(@key_val) if @key_val)  
  end

  def project
    @project ||= PdsProject.find(params[:pds_project_id]) if params[:pds_project_id]
  end

  def permit_params
    params[model.to_s.underscore]=params[:data][@ind]
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
