json.array!(@pds_equipments) do |pds_equipment|
  json.extract! pds_equipment, :id, :Project, :sys, :KKS, :eq_type, :Description_RU, :Description_EN, :type_equip, :sd_N
  json.url pds_equipment_url(pds_equipment, format: :json)
end
