class DisplaySystemsController < ApplicationController
  include GeneralControllerHelper

  ACTIONS = [:pds_ppca, :pds_ppcd, :pds_sd]

  before_action :project

  helper_method :table_data, :table_header, :editable_properties, :model_class

  # todo: сделать разбиение запроса на части, а то долго отдается
  def pds_ppcas
    # @data_list = PdsPpca.includes(:system).all
    @data_list = PdsPpca.includes(:system).limit(1000)
  end

  # todo: сделать разбиение запроса на части, а то долго отдается
  def pds_ppcds
    # @data_list = PdsPpcd.includes(:system).all
    @data_list = PdsPpcd.includes(:system).limit(1000)
  end

  def pds_sds
    @data_list = PdsSd.includes(:system).all
  end

  def create
    @pds_button = PdsButton.new permit_params

    if @pds_button.save
      format.json { render :show, status: :created, location: @pds_button }
    else
      format.json { render json: @pds_button.errors, status: :unprocessable_entity }
    end
  end

  def update
    Rails.logger.warn permit_params

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

  def destroy
    if current_object.destroy
      render json: {}, head: :no_content
    else
      render json: {errors: []}, status: 403
    end
  end

  private

  def current_object
    @current_object ||= model.find(params[:id])
  end

  def project
    @project ||= PdsProject.find(params[:pds_project_id])
  end

  def permit_params
    params.require(model.to_s.underscore).permit!
  end

  def table_data
    @data_list.map{ |e| e.custom_hash }.to_json
  end

end
