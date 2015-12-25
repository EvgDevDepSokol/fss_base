json.array!(@pds_sds) do |pds_sd|
  json.extract! pds_sd, :id, :SdTitle, :sys, :Project, :title_EN, :Numb, :BlobObj, :t, :from_sapfir
  json.url pds_sd_url(pds_sd, format: :json)
end
