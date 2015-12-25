json.array!(@pds_meters_channels) do |pds_meters_channel|
  json.extract! pds_meters_channel, :id, :IC, :sys, :Project, :ctrl_power, :t
  json.url pds_meters_channel_url(pds_meters_channel, format: :json)
end
