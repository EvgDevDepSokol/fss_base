class HwIosignaldim < ApplicationRecord
  self.table_name = 'hw_iosignaldim'
  self.inheritance_column = nil
  alias_attribute :id, primary_key

  def custom_hash
    serializable_hash
  end

  def serializable_hash(options = {})
    super options.merge(methods: :id)
  end
end
