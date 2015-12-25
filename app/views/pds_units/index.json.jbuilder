json.array!(@pds_units) do |pds_unit|
  json.extract! pds_unit, :id, :Unit_RU, :Unit_EN, :MultFactor, :ZeroShift, :t, :import_t
  json.url pds_unit_url(pds_unit, format: :json)
end
