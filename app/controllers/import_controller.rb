class ImportController < ApplicationController
  include GeneralControllerHelper

  before_action :project, :key_column
  helper_method :project, :key_column

  def update_all_check
    message = []
    if key_column_unique? then
      params[:data].each do |i, row|
        msg={add: false, result: '', err: ''}
        @permitted = row.permit!
        unless !!current_object(row[@key_column])
          msg[:add]=true
          @current_object=model.new
        end
        @current_object.attributes=@permitted
        if (!!@project) then
          @current_object.Project=@project.id
        end
        if (!@current_object.valid?) then
          msg[:err]=@current_object.errors.messages
        elsif(!@current_object.changed?) then
          msg[:err]='Аттрибуты не меняются!'
        end
        message.push(msg)
      end
    else
      message.push({not_unique: true, err: ''})
    end
    render json: { status: :ok, message: message}
  rescue
    render json: { status: :unprocessable_entity, message: message}
  end

  def update_all_finish
    message = []
    params[:data].each do |i, row|
      msg={add: false, result: '', err:''}
      @permitted = row.permit!
      unless !!current_object(row[@key_column])
        msg[:add]=true
        @current_object=model.new
      end
      @current_object.attributes=@permitted
      if (!!@project) then
        @current_object.Project=@project.id
      end
      if(@current_object.changed?) then
        msg[:err]= 'Аттрибуты не меняются!'
      elsif (!@current_object.save) then
        msg[:err]=@current_object.errors.messages
      else  
        msg[:result]=msg[:add]?'Запись успешно добавлена':'Запись успешно изменена'
      end
      message.push(msg)
    end
    render json: { status: :ok, message: message}
  rescue
    render json: { status: :unprocessable_entity, message: message}
  end

  private

  def current_object(val)
    if !!@project
      @current_object = model.find_by(@key_column => val, Project: @project)
      #@current_object = model.where(@key_column => val, Project: @project).first
    else
      @current_object = model.find_by(@key_column => val)
    end
  end

  def key_column
    @key_column = (params[:keyColumn] if params[:keyColumn])
  end

  def key_column_unique?
   if !!@project
      cnt_all  = model.where(Project: @project).count(@key_column)
      cnt_dist = model.where(Project: @project).count('distinct('+@key_column+')')
    else
      cnt_all  = model.count(@key_column)
      cnt_dist = model.count('distinct('+@key_column+')')
    end
    return cnt_all==cnt_dist
  end

  def project
    @project = PdsProject.find(params[:pds_project_id]) if (params[:pds_project_id]&&(model.has_attribute? :Project))
  end

  def table_data
    if model_class.method_defined? :custom_hash
      @data_list.map(&:custom_hash).to_json
    else
      @data_list.to_json
    end
  end
end
