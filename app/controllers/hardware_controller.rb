class HardwareController < ApplicationController
  include GeneralControllerHelper
  require 'csv'

  ACTIONS = [ :hw_ic, :hw_peds, :hw_wirelist, :pds_iomap, :hw_iosignaldefs,
    :hw_iosignals, :hw_devtypes, :hw_iosignaldim, :pds_panels]

  before_action :project

  helper_method :table_data, :table_header, :editable_properties, :model_class

  def index
    #Rails.logger.info params
    # для таблиц где есть ProjectID мы хотим видеть данные в контексте
    # данного проекта, для остальных пока отображаем все данные
    if model.new.respond_to?(:Project)
      @data_list = model.where(Project: project.ProjectID).limit(100)
    else
      @data_list = model.limit(100)
    end

    respond_to do |format|
      format.html { render index_view }
      format.csv
      format.xlsx
    end

  end

  def hw_ics
    @data_list = HwIc.where(Project: project.ProjectID).
      includes(hw_ped: [:hw_devtype], pds_panel: [])
  end

  def hw_peds
    @data_list = HwPed.where(Project: project.ProjectID).
      includes(:hw_devtype)
  end

  def hw_wirelists
    @data_list = HwWirelist.where(Project: project.ProjectID).
      includes(hw_ped: [:hw_devtype], pds_panel: [])
  end

  def pds_iomaps
    @data_list = PdsIomap.where(Project: project.ProjectID)
  end

  def hw_iosignaldefs
    @data_list = HwIosignaldef.all
  end

  def hw_iosignals
    @data_list = HwIosignal.where(Project: project.ProjectID)
  end

  def hw_devtypes
    @data_list = HwDevtype.all
  end

  def hw_iosignaldims
    @data_list = HwIosignaldim.where(Project: project.ProjectID)
  end

  def pds_panels
    @data_list = PdsPanel.where(Project: project.ProjectID)#.includes(:hw_ped, :panel)
  end

  def index_view
    if template_exists?("hardware/#{model_path}")
      "hardware/#{model_path}"
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
    if current_object.update(permit_params)
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
    if model_class.method_defined? :custom_hash
      @data_list.map{ |e| e.custom_hash }.to_json
    else
      @data_list.to_json
    end
  end

end
