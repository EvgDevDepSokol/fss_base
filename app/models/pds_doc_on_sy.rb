class PdsDocOnSy < ApplicationRecord
  self.table_name = 'pds_doc_on_sys'
  alias_attribute :id, primary_key
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_documentation, foreign_key: :Doc, class_name: 'PdsDocumentation'

  alias_attribute :system_id, :sys
  alias_attribute :pds_documentation_id, :Doc

  def self.plucked
    true
  end

  def custom_hash
    serializable_hash(include: {
                        pds_documentation: { only: %i[DocTitle Type NPP_Number Project] },
                        system: { only: [:System] }
                      })
  end
end
