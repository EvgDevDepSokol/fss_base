json.array!(@pds_blocks) do |pds_block|
  json.extract! pds_block, :id, :sys, :p_p, :Desc, :doc, :varName, :Project
  json.url pds_block_url(pds_block, format: :json)
end
