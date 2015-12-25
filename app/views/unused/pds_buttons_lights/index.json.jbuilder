json.array!(@pds_buttons_lights) do |pds_buttons_light|
  json.extract! pds_buttons_light, :id, :IC, :sys, :Project, :ctrl_power, :range, :Fixed, :t
  json.url pds_buttons_light_url(pds_buttons_light, format: :json)
end
