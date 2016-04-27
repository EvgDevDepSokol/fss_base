class ProjectSettingsController < ApplicationController
  include GeneralControllerHelper
  layout 'layouts/table'
  require 'csv'

  ACTIONS = [:pds_eng_on_sys, :pds_project_unit, :pds_doc_on_sys,
             :pds_project_sys, :week_report, :pds_documents,
             :pds_documentation, :pds_simplifications, :pds_queries,
             :pds_sys_description, :pds_dr, :pds_mathmodel].freeze

  before_action :project

  helper_method :project, :table_data, :table_header, :editable_properties, :model_class

  def index
    # Rails.logger.info params
    # для таблиц где есть ProjectID мы хотим видеть данные в контексте
    # данного проекта, для остальных пока отображаем все данные
    if model.new.respond_to?(:Project)
      @data_list = model.where(Project: project.ProjectID).limit(10_000)
    else
      @data_list = model.limit(10_000)
    end

    respond_to do |format|
      format.html { render index_view }
      format.csv
      format.xlsx
    end
  end

  def index_view
    if template_exists?("project_settings/#{model_path}")
      "project_settings/#{model_path}"
    else
      :index
    end
  end
  helper_method :index_view

  def pds_eng_on_sys
    @data_list = PdsEngOnSy.where(Project: project.ProjectID)
                           .includes(:pds_engineer, :pds_engineer_test, :system)
  end

  # TODO: не ясно как быть с выбором
  def pds_project_units
    @data_list = PdsProjectUnit.where(Project: project.ProjectID).includes(:unit)
  end

  def pds_doc_on_sys
    @data_list = PdsDocOnSy.includes(:pds_documentation, :system)
  end

  def pds_project_sys
    @data_list = PdsProjectSy.where(Project: project.ProjectID).includes(:system)
  end

  def week_reports
    @data_list = WeekReport.where(Project: project.ProjectID)
                           .includes(:pds_engineer, :system)
  end

  def pds_documents
    @data_list = PdsDocument.where(Project: project.ProjectID)
                            .includes(:pds_engineer, :working_engineer_ru, :working_engineer_en)
  end

  def pds_documentations
    @data_list = PdsDocumentation.where(Project: project.ProjectID)
  end

  def pds_simplifications
    @data_list = PdsSimplification.where(Project: project.ProjectID)
                                  .includes(:pds_query, :system)
  end

  def pds_sys_descriptions
    @data_list = PdsSysDescription.where(Project: project.ProjectID).includes(:system)
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

      render json: { status: :ok, data: current_object.custom_hash }
    else
      render json: { errors: current_object.errors, data: current_object.reload.custom_hash },
             status: :unprocessable_entity
    end

  rescue
    render json: { errors: current_object.errors, data: current_object.reload.custom_hash },
           status: :unprocessable_entity
  end

  def destroy
    # @pds_button.destroy
    if true
      render json: {}, head: :no_content
    else
      render json: { errors: [] }, status: 403
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
      model_class.attribute_names.reduce({}) do |hash, attr|
        hash.merge(
          attr => { type: model_class.columns_hash[attr].type,
                    title: attr })
      end.to_json
    end
  end

  def table_header
    if model_class.respond_to?(:view_columns)
      model_class.view_columns
    else
      model_class.attribute_names.map { |attr| { property: attr, header: attr } }.to_json
    end
  end

  def table_data
    if model_class.method_defined? :custom_hash
      @data_list.map(&:custom_hash).to_json
    else
      @data_list.to_json
    end
  end
end
