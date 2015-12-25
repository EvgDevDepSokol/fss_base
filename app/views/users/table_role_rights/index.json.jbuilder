json.array!(@table_role_rights) do |table_role_right|
  json.extract! table_role_right, :id, :tableID, :roleID, :value
  json.url table_role_right_url(table_role_right, format: :json)
end
