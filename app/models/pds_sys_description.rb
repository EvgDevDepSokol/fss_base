# frozen_string_literal: true

class PdsSysDescription < ApplicationRecord
  self.table_name = 'pds_sys_description'
  alias_attribute :id, primary_key

  belongs_to :pds_project, foreign_key: 'Project', inverse_of: :pds_sys_description
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist', inverse_of: :pds_sys_description

  alias_attribute :system_id, :sys

  def custom_hash
    serializable_hash(include: {
                        system: { only: [:System] }
                      })
  end
end
