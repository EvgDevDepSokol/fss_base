json.array!(@tblbinaries) do |tblbinary|
  json.extract! tblbinary, :id, :Title, :Type, :Length, :binObj, :t
  json.url tblbinary_url(tblbinary, format: :json)
end
