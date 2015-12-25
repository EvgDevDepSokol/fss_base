json.array!(@pds_engineers) do |pds_engineer|
  json.extract! pds_engineer, :id, :name, :TH, :TO, :L, :EL, :CR, :D, :SWM, :HWM, :PM, :t, :EMail, :CheifDirector, :login, :pwd, :dismiss, :coreID, :phoneNum, :cellNum, :IP, :compJack, :phoneJack, :sectorID1, :enabled
  json.url pds_engineer_url(pds_engineer, format: :json)
end
