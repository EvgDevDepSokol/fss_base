json.array!(@pds_syslists) do |pds_syslist|
  json.extract! pds_syslist, :id, :System, :Descriptor, :Category, :shortDesc, :shortDesc_EN
end
