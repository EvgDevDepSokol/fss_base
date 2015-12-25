json.array!(@pds_panels) do |pds_panel|
  json.extract! pds_panel, :id, :panel
end
