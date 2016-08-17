class PdsSd < ActiveRecord::Base
  self.table_name = 'pds_sd'
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  alias_attribute :system_id, :sys
  alias_attribute :title, :SdTitle

  def custom_hash
    serializable_hash(include: {
                        system: { only: :System }
                      })
  end

  def serializable_hash(options = {})
    super options.merge(methods: :id)
  end
end
