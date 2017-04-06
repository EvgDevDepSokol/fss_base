class PdsDocument < ApplicationRecord
  alias_attribute :id, primary_key
  belongs_to :pds_project, foreign_key: 'Project'
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_engineer, foreign_key: :Author
  belongs_to :working_engineer_ru, foreign_key: :CheckOutRu, class_name: 'PdsEngineer'
  belongs_to :working_engineer_en, foreign_key: :CheckOutEn, class_name: 'PdsEngineer'
  alias_attribute :system_id, :sys
  alias_attribute :pds_engineer_id, :Author

  def custom_hash
    serializable_hash(include: {
                        pds_engineer: { only: :name },
                        working_engineer_ru: { only: :name },
                        working_engineer_en: { only: :name },
                        system: { only: [:System] }
                      })
  end
end
