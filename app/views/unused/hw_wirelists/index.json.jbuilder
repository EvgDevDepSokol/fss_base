json.array!(@hw_wirelists) do |hw_wirelist|
  json.extract! hw_wirelist, :id, :from, :to, :wc, :nc, :io, :m, :s, :word, :bit, :power, :origin, :net, :ped, :Project, :rev, :Unit, :step, :t, :IC, :remarks, :io_signalID, :panel, :pds_mark
  json.url hw_wirelist_url(hw_wirelist, format: :json)
end
