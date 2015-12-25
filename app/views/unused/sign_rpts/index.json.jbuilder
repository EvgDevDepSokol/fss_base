json.array!(@sign_rpts) do |sign_rpt|
  json.extract! sign_rpt, :id, :engID, :engName, :BlobObj
  json.url sign_rpt_url(sign_rpt, format: :json)
end
