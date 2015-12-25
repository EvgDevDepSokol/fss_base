json.array!(@pds_filters) do |pds_filter|
  json.extract! pds_filter, :id, :kks, :ShortDesc, :Desc_EN, :level, :room, :Project, :sys, :eq_type, :var, :old_var, :sd_N
  json.url pds_filter_url(pds_filter, format: :json)
end
