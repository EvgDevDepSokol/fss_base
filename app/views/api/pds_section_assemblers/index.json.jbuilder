json.array!(@pds_section_assemblers) do |pds_section_assembler|
  json.extract! pds_section_assembler, :id, :section_name
end
