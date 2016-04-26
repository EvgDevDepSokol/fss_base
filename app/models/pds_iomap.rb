class PdsIomap < ActiveRecord::Base
  self.table_name = 'pds_iomap'

  def custom_hash
    serializable_hash
  end

  def serializable_hash(options = {})
    super options.merge(methods: :id)
  end
end
