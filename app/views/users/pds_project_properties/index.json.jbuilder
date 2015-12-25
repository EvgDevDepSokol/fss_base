json.array!(@pds_project_properties) do |pds_project_property|
  json.extract! pds_project_property, :id, :HostName, :HostIP, :SimDir, :ISName, :ISIP, :RootPass, :IOPass, :LoadPass, :TgisPass, :OSType, :LowLimKeyField, :UpLimKeyField, :Language, :Enabled, :ResName, :ClassLib, :ServicePort, :StatsInterval, :pdsCode, :fdsCode, :portS3serv, :report_prefix, :Encoding, :pmCode, :pmShortCode, :stCode, :stShortCode
  json.url pds_project_property_url(pds_project_property, format: :json)
end
