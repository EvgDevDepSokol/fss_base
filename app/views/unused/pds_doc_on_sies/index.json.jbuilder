json.array!(@pds_doc_on_sies) do |pds_doc_on_sy|
  json.extract! pds_doc_on_sy, :id, :Doc, :sys, :t
  json.url pds_doc_on_sy_url(pds_doc_on_sy, format: :json)
end
