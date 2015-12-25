json.array!(@pds_eng_on_sies) do |pds_eng_on_sy|
  json.extract! pds_eng_on_sy, :id, :sys, :Project, :engineer_N, :t, :TestOperator_N
  json.url pds_eng_on_sy_url(pds_eng_on_sy, format: :json)
end
