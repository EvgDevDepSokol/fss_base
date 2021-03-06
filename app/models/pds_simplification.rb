# frozen_string_literal: true

class PdsSimplification < ApplicationRecord
  alias_attribute :id, primary_key
  belongs_to :pds_project, foreign_key: 'Project'
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_query, foreign_key: 'queryID'

  alias_attribute :system_id, :sys
  alias_attribute :pds_query_id, :queryID

  def custom_hash
    serializable_hash(include: {
                        system: { only: [:System] },
                        pds_query: { only: [:queryNumber] }
                      })
  end
end
