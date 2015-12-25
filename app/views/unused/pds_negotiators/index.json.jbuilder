json.array!(@pds_negotiators) do |pds_negotiator|
  json.extract! pds_negotiator, :id, :name, :post, :Project, :chef, :ord
  json.url pds_negotiator_url(pds_negotiator, format: :json)
end
