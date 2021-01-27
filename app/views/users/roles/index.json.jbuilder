# frozen_string_literal: true

json.array!(@roles) do |role|
  json.extract! role, :id, :role, :Desc
  json.url role_url(role, format: :json)
end
