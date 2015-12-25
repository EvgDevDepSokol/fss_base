json.array!(@hw_devtypes) do |hw_devtype|
  json.extract! hw_devtype, :id, :RuName, :EnName, :typetable
end
