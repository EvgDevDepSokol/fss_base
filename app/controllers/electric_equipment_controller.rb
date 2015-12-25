class ElectricEquipmentController < ApplicationController
  include GeneralControllerHelper
  require 'csv'

  ACTIONS = [:pds_breakers, :pds_equipments, :pds_section_assembler]

  before_action :project, only: :index

  helper_method :table_data, :table_header, :editable_properties, :model_class

  def index
    #Rails.logger.info params
    # для таблиц где есть ProjectID мы хотим видеть данные в контексте
    # данного проекта, для остальных пока отображаем все данные
    if model.new.respond_to?(:Project)
      @data_list = model.where(Project: project.ProjectID).limit(10000)
    else
      @data_list = model.limit(10000)
    end

    respond_to do |format|
      format.html { render index_view }
      format.csv
      format.xlsx
    end

  end

  def index_view
    if template_exists?("electric_equipment/#{model_path}")
      "electric_equipment/#{model_path}"
    else
      :index
    end
  end
  helper_method :index_view

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

      render json: {status: :ok, data: current_object.serializable_hash}
    else
      render json: {errors: current_object.errors, data: current_object.reload.serializable_hash},
             status: :unprocessable_entity
    end

  rescue
    render json: {errors: current_object.errors, data: current_object.reload.serializable_hash},
           status: :unprocessable_entity
  end

  def destroy
    # @pds_button.destroy
    if true
      render json: {}, head: :no_content
    else
      render json: {errors: []}, status: 403
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_pds_button
    @current_object = model.find(params[:id])
  end

  def current_object
    @current_object ||= model.find(params[:id])
  end

  def project
    @project ||= PdsProject.find(params[:pds_project_id])
  end

  def permit_params
    params.require(model.to_s.underscore).permit!
  end

  def editable_properties
    if model_class.respond_to?(:editable_attributes)
      model_class.editable_attributes.to_json
    else
      model_class.attribute_names.reduce({}){ |hash, attr| hash.merge(
          attr => {type: model_class.columns_hash[attr].type,
                   title: attr})}.to_json
    end

  end

  def table_header
    if model_class.respond_to?(:view_columns)
      model_class.view_columns
    else
      model_class.attribute_names.map{ |attr| {property: attr, header: attr}}.to_json
    end
  end

  def table_data
    @data_list.to_json
  end

end
