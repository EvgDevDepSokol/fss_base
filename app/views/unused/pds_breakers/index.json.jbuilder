json.array!(@pds_breakers) do |pds_breaker|
  json.extract! pds_breaker, :id, :sys, :Project, :tag_RU, :tag_EN, :ed_power, :ctrl_power, :anc_power, :Time, :Algorithm, :Desc_RU, :Desc_EN, :model, :eq_type, :connection, :sd_N
  json.url pds_breaker_url(pds_breaker, format: :json)
end
