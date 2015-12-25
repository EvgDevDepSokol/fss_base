json.array!(@pds_malfunction_dims) do |pds_malfunction_dim|
  json.extract! pds_malfunction_dim, :id, :Project, :Malfunction, :Character, :Target_EN, :Target, :sd_N, :is_main
  json.url pds_malfunction_dim_url(pds_malfunction_dim, format: :json)
end
