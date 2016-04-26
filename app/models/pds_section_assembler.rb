class PdsSectionAssembler < ActiveRecord::Base
  self.table_name = 'pds_section_assembler'
  belongs_to :pds_project, foreign_key: 'Project'

  # def serializable_hash(options={})
  #   super.merge({id: id})
  # end
  def custom_hash
    serializable_hash.merge(id: id)
  end
end
