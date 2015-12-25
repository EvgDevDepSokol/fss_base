json.array!(@hw_peds) do |hw_ped|
  json.extract! hw_ped, :id, :ped
end
