json.array!(@pds_announciators) do |pds_announciator|
  json.extract! pds_announciator, :id, :IC, :Project, :sys, :ctrl_power, :t, :Type, :Gr_Dreg, :Detector, :Characteristics, :sign, :Code
  json.url pds_announciator_url(pds_announciator, format: :json)
end
