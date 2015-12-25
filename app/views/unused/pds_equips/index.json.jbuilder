json.array!(@pds_equips) do |pds_equip|
  json.extract! pds_equip, :id, :typeE
  json.url pds_equip_url(pds_equip, format: :json)
end
