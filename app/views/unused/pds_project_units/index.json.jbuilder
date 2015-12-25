json.array!(@pds_project_units) do |pds_project_unit|
  json.extract! pds_project_unit, :id, :Project, :Unit, :t
  json.url pds_project_unit_url(pds_project_unit, format: :json)
end
