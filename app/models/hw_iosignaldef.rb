class HwIosignaldef < ActiveRecord::Base
  self.table_name = 'hw_iosignaldef'

  def custom_hash
    serializable_hash
  end

  def serializable_hash(options = {})
    super options.merge(methods: :id)
  end
end
