# frozen_string_literal: true

json.array!(@news) do |news|
  json.extract! news, :id, :news, :t, :date
  json.url news_url(news, format: :json)
end
