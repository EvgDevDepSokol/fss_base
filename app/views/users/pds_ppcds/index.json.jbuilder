json.array!(@pds_ppcds) do |pds_ppcd|
  json.extract! pds_ppcd, :id, :Project, :sys, :Shifr, :Key, :identif, :Description, :Description_EN, :Detector, :t, :code
  json.url pds_ppcd_url(pds_ppcd, format: :json)
end
