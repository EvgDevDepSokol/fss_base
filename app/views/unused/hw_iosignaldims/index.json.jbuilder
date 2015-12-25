json.array!(@hw_iosignaldims) do |hw_iosignaldim|
  json.extract! hw_iosignaldim, :id, :Project, :signID, :num, :type, :suff
  json.url hw_iosignaldim_url(hw_iosignaldim, format: :json)
end
