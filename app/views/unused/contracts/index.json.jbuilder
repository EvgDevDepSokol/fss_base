json.array!(@contracts) do |contract|
  json.extract! contract, :id, :contr_Num, :Project, :state, :date, :Desc
  json.url contract_url(contract, format: :json)
end
