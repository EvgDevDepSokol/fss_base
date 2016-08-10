json.array!(@hw_iosignaldefs) do |hw_iosignaldef|
  json.extract! hw_iosignaldef, :id, :ioname
end
