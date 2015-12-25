json.array!(@companies) do |company|
  json.extract! company, :id, :shortName, :shortName_en, :LongName, :LongName_en, :Descriprion, :Logo, :AcceptorPost_en, :AcceptorPost, :AcceptorName_en, :AcceptorName
  json.url company_url(company, format: :json)
end
