json.array!(@pds_man_equips) do |pds_man_equip|
  json.extract! pds_man_equip, :id, :Type
end
