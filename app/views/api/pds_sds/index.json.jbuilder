json.array!(@pds_sds) do |pds_sd|
  json.id pds_sd.id
  json.Numb pds_sd.Numb
  json.System pds_sd.system.System
end
