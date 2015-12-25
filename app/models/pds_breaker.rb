class PdsBreaker < ActiveRecord::Base

  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_project, foreign_key: 'Project'

  alias_attribute :system_id, :sys

  # todo: fix system
  def serializable_hash(options={})
    super.merge({id: id, system: system.to_s})
  end
end
