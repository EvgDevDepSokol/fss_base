# frozen_string_literal: true

class PdsEngOnSy < ApplicationRecord
  self.table_name = 'pds_eng_on_sys'
  alias_attribute :id, primary_key
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_engineer, foreign_key: :engineer_N
  belongs_to :pds_engineer_test, foreign_key: :TestOperator_N, class_name: 'PdsEngineer'
  alias_attribute :system_id, :sys
  alias_attribute :pds_engineer_id, :engineer_N
  alias_attribute :pds_engineer_test_id, :TestOperator_N

  def custom_hash
    serializable_hash(include: {
                        pds_engineer: { only: :name },
                        pds_engineer_test: { only: :name },
                        system: { only: [:System] }
                      })
  end
end
