class HwIosignal < ActiveRecord::Base

  self.table_name = 'hw_iosignal'

  def custom_hash
    serializable_hash
  end

  def serializable_hash(options={})
    super options.merge(methods: :id)
  end

end
