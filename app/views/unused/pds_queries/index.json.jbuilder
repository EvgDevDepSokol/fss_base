json.array!(@pds_queries) do |pds_query|
  json.extract! pds_query, :id, :Project, :sys, :queryNumber, :query_make_date, :answer_expected_date, :query_essence, :engineer_N, :query_transfer_date, :answer_date, :answer_essence, :who_answered, :if_close, :Assumption, :t
  json.url pds_query_url(pds_query, format: :json)
end
