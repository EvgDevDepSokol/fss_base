json.array!(@tablelists) do |tablelist|
  json.extract! tablelist, :id, :table, :title, :Desc, :BlobObj, :number
  json.url tablelist_url(tablelist, format: :json)
end
