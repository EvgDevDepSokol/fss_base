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

  before_save do |pds_sd|
    pds_sd.Numb=pds_sd.Numb.rjust(2,'0')
  end  
  
  def serializable_hash(options = {})
    super options.merge(methods: :id)
  end
end
