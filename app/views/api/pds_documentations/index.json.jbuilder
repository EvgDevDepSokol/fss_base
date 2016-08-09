json.array!(@pds_documentations) do |pds_documentation|
  json.extract! pds_documentation, :id, :DocTitle
end
