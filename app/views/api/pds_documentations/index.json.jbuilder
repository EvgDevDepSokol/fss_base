json.array!(@pds_documentations) do |pds_documentation|
  json.extract! pds_documentation, :id, :DocTitle
  json.url pds_documentation_url(pds_documentation, format: :json)
end
