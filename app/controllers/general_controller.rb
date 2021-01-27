# frozen_string_literal: true

# General controller
class GeneralController < ApplicationController
  include GeneralControllerHelper
  require 'csv'

  before_action :set_pds_button, only: [:show]
  before_action :project, only: :index

  # GET /pds_buttons
  # GET /pds_buttons.json
  def index
    # Rails.logger.info params
    # для таблиц где есть ProjectID мы хотим видеть данные в контексте
    # данного проекта, для остальных пока отображаем все данные
    if false && model.new.respond_to?(:Project)
      @grid = initialize_grid(model.where(Project: project.ProjectID), name: 'general')
      @data_list = model.where(Project: project.ProjectID).limit(10_000)
    else
      @grid = initialize_grid(model, name: 'general')
      @data_list = model.limit(10_000)
    end

    respond_to do |format|
      format.html { render index_view }
      format.csv
      format.xlsx
    end
  end

  def index_view
    (template_exists?("#{model_path}/index") ? "#{model_path}/index" : :index)
    # if %(pds_lamp).include? model_path
    #  params[:model]
    # else
    #  :index
    # end
  end

  # GET /pds_buttons/1
  # GET /pds_buttons/1.json
  def show; end

  # GET /pds_buttons/new
  def new
    @pds_button = PdsButton.new
  end

  # GET /pds_buttons/1/edit
  def edit; end

  # POST /pds_buttons
  # POST /pds_buttons.json
  def create
    @pds_button = PdsButton.new(pds_button_params)

    respond_to do |format|
      if @pds_button.save
        format.html { redirect_to @pds_button, notice: 'Pds button was successfully created.' }
        format.json { render :show, status: :created, location: @pds_button }
      else
        format.html { render :new }
        format.json { render json: @pds_button.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pds_buttons/1
  # PATCH/PUT /pds_buttons/1.json
  def update
    respond_to do |format|
      if current_object.update(pds_button_params)
        format.html { redirect_to current_object, notice: 'Pds button was successfully updated.' }
        format.json { render json: { status: :ok, data: current_object.serializable_hash } }
      else
        format.html { render :edit }
        format.json do
          render json: { errors: current_object.errors, data: current_object.reload.serializable_hash },
                 status: :unprocessable_entity
        end
      end
    end
  rescue StandardError
    respond_to do |format|
      format.html { render :edit }
      format.json do
        render json: { errors: current_object.errors, data: current_object.reload.serializable_hash },
               status: :unprocessable_entity
      end
    end
  end

  # DELETE /pds_buttons/1.json
  def destroy
    # @pds_button.destroy
    if true
      render json: {}, head: :no_content
    else
      render json: { errors: [] }, status: :forbidden
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

  # Never trust parameters from the scary internet, only allow the white list through.
  def pds_button_params
    params.require(model.to_s.underscore).permit! # permit(:IC, :sys, :Project, :range, :Fixed, :t)
  end

  def editable_properties
    model_class.attribute_names.map { |attr| { property: attr, header: attr } }
  end

  def table_header
    model_class.attribute_names.map { |attr| { property: attr, header: attr } }
  end

  def table_data
    @data
  end
end
