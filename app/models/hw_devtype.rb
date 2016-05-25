class HwDevtype < ActiveRecord::Base
  self.table_name = 'hw_devtype'

  belongs_to :tablelist, foreign_key: :typetable, class_name: 'Tablelist'
  alias_attribute :tablelist_id, :typetable

  def custom_hash
    serializable_hash(include: {
      tablelist:{only: :title}})
  end

#  def serializable_hash(options = {})
#    super options.merge(methods: :id)
#  end
end
