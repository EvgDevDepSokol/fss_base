json.array!(@pds_iomaps) do |pds_iomap|
  json.extract! pds_iomap, :id, :Project, :hwaddress, :io_point_name, :number_of_array_elem, :sid, :comp_name, :remark, :t
  json.url pds_iomap_url(pds_iomap, format: :json)
end
