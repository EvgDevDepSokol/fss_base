class HwIosignaldim < ActiveRecord::Base
  self.table_name = 'hw_iosignaldim'
  self.inheritance_column = nil
  alias_attribute :id, self.primary_key

  def custom_hash
    serializable_hash
  end

  def serializable_hash(options = {})
    super options.merge(methods: :id)
  end
end
