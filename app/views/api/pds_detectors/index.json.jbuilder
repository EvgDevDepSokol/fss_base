json.array!(@pds_detectors) do |pds_detector|
  json.extract! pds_detector, :id, :tag
  json.url pds_detector_url(pds_detector, format: :json)
end
