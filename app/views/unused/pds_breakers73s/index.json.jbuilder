json.array!(@pds_breakers73s) do |pds_breakers73|
  json.extract! pds_breakers73, :id, :System, :tag_RU, :tag_EN, :Desc_RU, :Desc_EN
  json.url pds_breakers73_url(pds_breakers73, format: :json)
end
