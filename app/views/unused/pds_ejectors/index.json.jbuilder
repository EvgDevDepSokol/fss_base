json.array!(@pds_ejectors) do |pds_ejector|
  json.extract! pds_ejector, :id, :kks, :ShortDesc, :Desc_EN, :capacity, :level, :room, :Project, :sys, :eq_type, :Unit, :sd_N
  json.url pds_ejector_url(pds_ejector, format: :json)
end
