json.array!(@pds_valves) do |pds_valf|
  json.extract! pds_valf, :id, :tag_RU
end
