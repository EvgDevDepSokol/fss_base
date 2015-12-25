json.array!(@pds_recorders) do |pds_recorder|
  json.extract! pds_recorder, :id, :IC, :sys, :Project, :ctrl_power, :t
  json.url pds_recorder_url(pds_recorder, format: :json)
end
