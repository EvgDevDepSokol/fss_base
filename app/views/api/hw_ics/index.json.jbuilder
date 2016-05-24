json.array!(@hw_ics) do |hw_ic|
  json.extract! hw_ic, :id, :ref
end
