json.array!(@pds_mnemos) do |pds_mnemo|
  json.extract! pds_mnemo, :id, :sys, :Project, :Code, :Marker, :TechCode, :Type, :Opened, :Closed, :Control, :AutoDist, :Parameter, :Description, :Description_EN, :Gr_Dreg, :Detector, :Characteristics
  json.url pds_mnemo_url(pds_mnemo, format: :json)
end
