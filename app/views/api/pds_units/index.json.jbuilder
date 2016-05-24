json.array!(@pds_units) do |pds_unit|
  json.extract! pds_unit, :id, :Unit_RU
end
