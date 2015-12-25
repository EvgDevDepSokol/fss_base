json.array!(@audits) do |audit|
  json.extract! audit, :id, :Project, :table_name, :tag_RU, :tag_EN, :sys, :field_changed, :id, :old_value, :new_value, :t
  json.url audit_url(audit, format: :json)
end
