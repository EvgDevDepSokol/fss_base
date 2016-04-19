json.array!(@pds_project_units) do |pds_project_unit|
  json.id pds_project_unit.ProjUnitID
  json.Unit_RU pds_project_unit.unit.Unit_RU
end
