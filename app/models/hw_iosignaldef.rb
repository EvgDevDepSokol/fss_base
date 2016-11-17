class HwIosignaldef < ActiveRecord::Base
  self.table_name = 'hw_iosignaldef'

  has_many :hw_iosignal, dependent: :restrict_with_error, foreign_key: 'signID'

  def custom_hash
    serializable_hash
  end
#
#  def serializable_hash(options = {})
#    super options.merge(methods: :id)
#  end
end
