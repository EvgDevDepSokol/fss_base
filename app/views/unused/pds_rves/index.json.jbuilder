json.array!(@pds_rves) do |pds_rf|
  json.extract! pds_rf, :id, :sys, :Project, :name_RU, :name, :tag_RU, :Desc, :Desc_EN, :range, :Unit, :type, :Type_FB, :unit_FB, :range_FB, :rate, :Ptag, :sd_N, :t, :typerf, :scale, :frfID
  json.url pds_rf_url(pds_rf, format: :json)
end
