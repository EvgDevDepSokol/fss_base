json.array!(@pds_mathmodels) do |pds_mathmodel|
  json.extract! pds_mathmodel, :id, :Project, :sys, :task_N, :Desc_RU, :Desc_EN
  json.url pds_mathmodel_url(pds_mathmodel, format: :json)
end
