json.array!(@pds_simplifications) do |pds_simplification|
  json.extract! pds_simplification, :id, :sys, :Project, :Numb, :Desc, :Desc_EN, :support, :support_EN, :queryID, :t
  json.url pds_simplification_url(pds_simplification, format: :json)
end
