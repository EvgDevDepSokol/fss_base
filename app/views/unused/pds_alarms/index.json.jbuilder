json.array!(@pds_alarms) do |pds_alarm|
  json.extract! pds_alarm, :id, :IC, :sys, :Project, :t
  json.url pds_alarm_url(pds_alarm, format: :json)
end
