json.array!(@pds_syslists) do |pds_syslist|
  json.extract! pds_syslist, :id, :System
end
