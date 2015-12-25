class PdsSyslist < ActiveRecord::Base

  self.table_name = 'pds_syslist'

  alias_attribute :title, :System

  def to_s
    self.System
  end

  def serializable_hash(options={})
    super options.merge(methods: :id)
  end

end
