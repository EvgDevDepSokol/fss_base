json.array!(@pds_breakers62s) do |pds_breakers62|
  json.extract! pds_breakers62, :id, :System, :tag_RU, :tag_EN, :Desc_RU, :Desc_EN
  json.url pds_breakers62_url(pds_breakers62, format: :json)
end
