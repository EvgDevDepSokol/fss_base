# frozen_string_literal: true

class PdsBlock < ApplicationRecord
  alias_attribute :id, primary_key
  belongs_to :pds_project, foreign_key: 'Project'
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  alias_attribute :system_id, :sys

  def custom_hash
    serializable_hash(include: {
                        system: { only: :System }
                      })
  end
end
