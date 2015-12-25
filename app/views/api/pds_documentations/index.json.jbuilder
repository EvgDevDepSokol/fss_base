json.array!(@pds_documentations) do |pds_documentation|
  json.extract! pds_documentation, :id, :Project, :Type, :NPP_Number, :Revision, :reg_ID, :getting_date, :DocTitle, :DocTitle_EN, :Hardcopy, :File, :t
  json.url pds_documentation_url(pds_documentation, format: :json)
end
