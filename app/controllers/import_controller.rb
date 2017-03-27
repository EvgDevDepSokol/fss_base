class ImportController < ApplicationController
  #Import data from excel module
  include GeneralControllerHelper

  before_action :current_project, :key_column
  helper_method :current_project, :key_column

  def update_all_check
    message = []
    byebug
    if key_column_unique? then
      params[:data].each do |i, row|
        msg={add: false, result: '', err: [], warn: ''}
        unless !!current_object(row[key_column])
          msg[:add]=true
          @current_object=model.new
        end
        @current_object.attributes=row.except(:err0).permit!
        if (@current_project) then
          @current_object.Project=@current_project
        end
        if (!!row[:err0]) then
          #msg[:err]=row[:err0]
        elsif (msg[:add]&&(current_user.user_rights<=1)) then
          msg[:err]=['Нет прав на добавление записи!']
        elsif (!@current_object.valid?) then
          msg[:err]=@current_object.errors.full_messages
        elsif(!@current_object.changed?) then
          msg[:warn]='Аттрибуты не меняются!'
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
      msg={add: false, result: '', err: [], warn: ''}
      unless !!current_object(row[key_column])
        msg[:add]=true
        @current_object=model.new
      end
      @current_object.attributes=row.except(:err0).permit!
      if (@current_project) then
        @current_object.Project=@current_project
      end
      if (!!row[:err0]) then
        #msg[:err]=row[:err0]
      elsif (msg[:add]&&(current_user.user_rights<=1)) then
        msg[:err]=['Нет прав на добавление записи!']
      elsif(@current_object.changed?) then
        msg[:warn]= 'Аттрибуты не меняются!'
      elsif (!@current_object.save) then
        msg[:err]=@current_object.errors.full_messages
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

  def initialize
    @current_object = nil
    @current_project = nil
  end

  def current_object(val)
    if !!@current_project
      @current_object = model.find_by(key_column => val, Project: @current_project)
      #@current_object = model.where(key_column => val, Project: @current_project).first
    else
      @current_object = model.find_by(key_column => val)
    end
  end

  def key_column
    params[:keyColumn]
  end

  def key_column_unique?
    column_name=params[:keyColumn]
    column_name=model.attribute_alias?(column_name)?model.attribute_alias(column_name):column_name
    if !!@current_project
      cnt_all  = model.where(Project: @current_project).count(column_name)
      cnt_dist = model.where(Project: @current_project).distinct.count(column_name)
    else
      cnt_all  = model.count(column_name)
      cnt_dist = model.distinct.count(column_name)
    end
    return cnt_all==cnt_dist
  end

  def current_project
    project_id=params[:pds_project_id]
    @current_project=PdsProject.find(project_id).id if (project_id&&(model.has_attribute? :Project))
  end
end
