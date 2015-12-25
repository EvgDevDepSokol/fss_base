json.array!(@pds_volumes) do |pds_volume|
  json.extract! pds_volume, :id, :kks, :ShortDesc, :Desc_EN, :volume, :height, :level, :room, :Project, :sys, :eq_type, :sd_N
  json.url pds_volume_url(pds_volume, format: :json)
end
