json.array!(@hw_iosignaldefs) do |hw_iosignaldef|
  json.extract! hw_iosignaldef, :id, :ioname, :memtype, :rem
  json.url hw_iosignaldef_url(hw_iosignaldef, format: :json)
end
