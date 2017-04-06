class HwIosignaldef < ApplicationRecord
  self.table_name = 'hw_iosignaldef'
  alias_attribute :id, primary_key

  has_many :hw_iosignal, dependent: :restrict_with_error, foreign_key: 'signID'

  def custom_hash
    serializable_hash
  end
  #
  #  def serializable_hash(options = {})
  #    super options.merge(methods: :id)
  #  end
end
