json.array!(@pds_alg_types) do |pds_alg_type|
  json.extract! pds_alg_type, :id, :Project, :alg_type, :numb
  json.url pds_alg_type_url(pds_alg_type, format: :json)
end
