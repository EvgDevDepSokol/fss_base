json.array!(@pds_meters) do |pds_meter|
  json.extract! pds_meter, :id, :IC, :sys, :Project, :ctrl_power, :t
  json.url pds_meter_url(pds_meter, format: :json)
end
