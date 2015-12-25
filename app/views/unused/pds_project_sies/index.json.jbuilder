json.array!(@pds_project_sies) do |pds_project_sy|
  json.extract! pds_project_sy, :id, :Project, :Station_sys, :sys, :Desc_RU, :Desc_EN, :t
  json.url pds_project_sy_url(pds_project_sy, format: :json)
end
