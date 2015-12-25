json.array!(@pds_regulators) do |pds_regulator|
  json.extract! pds_regulator, :id, :model, :Project, :sys, :tag_RU, :tag_EN, :station_sys, :Desc, :ed_power, :ctrl_power, :anc_power, :nom_state, :open_rate, :close_rate, :sd_N, :doc_reg_N, :Algorithm, :t, :Desc_EN, :import_t, :mod, :vlv, :vlv_1, :vlv_2, :det_id, :eq_type, :par_val
  json.url pds_regulator_url(pds_regulator, format: :json)
end
