# frozen_string_literal: true

json.extract! @pds_project_property, :id, :HostName, :HostIP, :SimDir, :ISName, :ISIP, :RootPass, :IOPass, :LoadPass, :TgisPass, :OSType, :LowLimKeyField, :UpLimKeyField, :Language, :Enabled, :ResName, :ClassLib, :ServicePort, :StatsInterval, :pdsCode, :fdsCode, :portS3serv, :report_prefix, :Encoding, :pmCode, :pmShortCode, :stCode, :stShortCode, :created_at, :updated_at
