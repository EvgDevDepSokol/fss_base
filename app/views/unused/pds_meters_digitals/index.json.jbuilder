json.array!(@pds_meters_digitals) do |pds_meters_digital|
  json.extract! pds_meters_digital, :id, :IC, :sys, :Project, :ctrl_power, :t
  json.url pds_meters_digital_url(pds_meters_digital, format: :json)
end
