json.array!(@pds_documents) do |pds_document|
  json.extract! pds_document, :id, :DocTitle, :Code, :Author, :Project, :FileRu, :FileEn, :CheckOutRu, :t, :CheckOutEn
  json.url pds_document_url(pds_document, format: :json)
end
