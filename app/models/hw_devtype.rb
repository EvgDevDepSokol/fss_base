class HwDevtype < ActiveRecord::Base
  self.table_name = 'hw_devtype'

  def custom_hash
    serializable_hash
  end

  def serializable_hash(options = {})
    super options.merge(methods: :id)
  end
end
