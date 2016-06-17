module ViewHelper
  def edit_button(object)
    content_tag(:button,
                content_tag(:span, '', class: 'fa fa-pencil'),
                class: 'btn btn-default edit btn-xs') +
      content_tag(:button, 'save', class: 'btn btn-primary btn-xs save',
                                   style: 'display:none', 'data-url' => url_for(object))
  end

  def editable_select(object, system_name, val_name)
    val = object.send(val_name)
    content_tag(:span, val, class: 'editable',
                            'data-name' => val_name,
                            'data-attribute' => system_name,
                            'data-type' => 'select2',
                            'data-value' => val,
                            id: val_name)
  end

  def editable_input(object, attr)
    content_tag(:span, object.send(attr), class: 'editable',
                                          'data-attribute' => attr)
  end

  def project_menu_line(model, project)
    content_tag(:tr) do
      content_tag(:td) do
        link_to TableList[model], url_for([:index, project, plural_model(model)])
      end +
        content_tag(:td) do
          link_to url_for([:index, project, plural_model(model)]) do
            image_tag 'OpenTable.gif'
          end
        end
    end
  end

  def menu_line(model)
    content_tag(:tr) do
      content_tag(:td) do
        link_to TableList[model], url_for(plural_model(model))
      end +
        content_tag(:td) do
          link_to url_for(plural_model(model)) do
            image_tag 'OpenTable.gif'
          end
        end
    end
  end

  def plural_model(model)
    model.to_s.pluralize
  end

  def controller_actions_list(controller, project = nil)
    controller::ACTIONS.map do |model|
      { label: TableList[model],
        table: model,
        href: url_for([:index, project, plural_model(model)]),
        current: params[:model] == model
      }
    end.to_json
  end

  def current_user_rights
    current_user.user_rights
  end
end
