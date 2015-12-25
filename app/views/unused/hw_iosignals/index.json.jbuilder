json.array!(@hw_iosignals) do |hw_iosignal|
  json.extract! hw_iosignal, :id, :Project, :pedID, :signID, :wirecode, :contact, :sw_pref, :sw_suff, :hw_suff, :comment, :contactnum, :description, :diapason, :limits, :t, :temp
  json.url hw_iosignal_url(hw_iosignal, format: :json)
end
