json.array!(@pds_sds) do |pds_sd|
  json.extract! pds_sd, :id, :SdTitle
end
