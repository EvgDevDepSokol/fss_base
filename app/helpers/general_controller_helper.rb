module GeneralControllerHelper
  PROJECT_LIST = [90, 87, 83, 80_000_001, 80_000_003, 88].freeze
  def model
    @model ||= params[:model].to_s.classify.constantize
  end

  def model_class
    model
  end

  def title
    TableList[params[:model].to_sym] || model.to_s
  end

  def mt(attribute, model)
    I18n.t(attribute, scope: [:activerecord, :attributes, model.to_s.underscore])
  end

  def lt(attribute, model)
    "#{mt(attribute, model)} #{link_to 'O', url_for([:index, @project, attribute.to_s.pluralize])}".html_safe
  end

  # множественное число от имени модели
  def model_path
    params[:model].to_s.pluralize
  end

  def hash_model_name
    params[:model].to_s.singularize
  end
end
