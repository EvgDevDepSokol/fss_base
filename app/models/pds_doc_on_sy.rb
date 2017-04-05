class PdsDocOnSy < ActiveRecord::Base
  alias_attribute :id, primary_key
  self.table_name = 'pds_doc_on_sys'
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_documentation, foreign_key: :Doc
  alias_attribute :system_id, :sys
  alias_attribute :pds_documentation_id, :Doc

  def custom_hash
    serializable_hash(include: {
                        pds_documentation: { only: %i[DocTitle Type NPP_Number Project] },
                        system: { only: [:System] }
                      })
  end
end
