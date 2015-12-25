json.array!(@accs) do |acc|
  json.extract! acc, :id, :Project, :ped, :Name, :number, :SH, :SV, :tag_no, :store, :scale_min, :scale_max, :Unit, :MP_CMEMO, :pa
  json.url acc_url(acc, format: :json)
end
