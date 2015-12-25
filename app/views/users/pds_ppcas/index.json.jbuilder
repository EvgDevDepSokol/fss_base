json.array!(@pds_ppcas) do |pds_ppca|
  json.extract! pds_ppca, :id, :Project, :sys, :Shifr, :Key, :identif, :Description, :Description_EN, :Detector, :Unit, :L_lim, :U_lim, :nom, :LA, :LW, :HW, :HA, :t, :code, :power, :UnitID
  json.url pds_ppca_url(pds_ppca, format: :json)
end
