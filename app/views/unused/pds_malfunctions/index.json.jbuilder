json.array!(@pds_malfunctions) do |pds_malfunction|
  json.extract! pds_malfunction, :id, :sys, :Dimension, :Project, :Numb, :shortDesc, :shortDesc_EN, :cause, :cause_EN, :fullDesc, :fullDesc_EN, :type, :if_delete, :if_delete_EN, :lowlim_regidity, :uplim_regidity, :regidity_unit, :regidity_text, :regidity_text_EN, :Unit_status, :t, :File, :regidity_unitid, :scale, :sd_N
  json.url pds_malfunction_url(pds_malfunction, format: :json)
end
