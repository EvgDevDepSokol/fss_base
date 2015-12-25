json.array!(@pds_detectors) do |pds_detector|
  json.extract! pds_detector, :id, :tag
end