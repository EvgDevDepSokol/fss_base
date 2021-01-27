# frozen_string_literal: true

json.array!(@pds_buttons) do |pds_button|
  json.extract! pds_button, :id, :IC, :sys, :Project, :range, :Fixed, :t
  json.url pds_button_url(pds_button, format: :json)
end
