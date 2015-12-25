json.array!(@pds_sys_descriptions) do |pds_sys_description|
  json.extract! pds_sys_description, :id, :Project, :sys, :Description, :Description_EN, :shortDesc, :shortDesc_EN
  json.url pds_sys_description_url(pds_sys_description, format: :json)
end
