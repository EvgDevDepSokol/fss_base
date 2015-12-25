class PdsDocOnSy < ActiveRecord::Base

  self.table_name = 'pds_doc_on_sys'
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_documentation, foreign_key: :Doc
  alias_attribute :system_id, :sys
  alias_attribute :pds_documentation_id, :Doc

  def custom_hash
    serializable_hash(include: {
        pds_documentation: { only: [:DocTitle, :Type, :NPP_Number] },
        system: {only: [:System]}})
  end

end
