json.array!(@pds_breakers60s) do |pds_breakers60|
  json.extract! pds_breakers60, :id, :System, :tag_RU, :tag_EN, :Desc_RU, :Desc_EN
  json.url pds_breakers60_url(pds_breakers60, format: :json)
end
