json.array!(@pds_hexes) do |pds_hex|
  json.extract! pds_hex, :id, :kks, :ShortDesc, :s, :level, :room, :Project, :sys, :eq_type, :var, :old_var, :Desc_EN, :sd_N
  json.url pds_hex_url(pds_hex, format: :json)
end
