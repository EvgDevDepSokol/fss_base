class HwDevtype < ActiveRecord::Base
  self.table_name = 'hw_devtype'
  alias_attribute :id, primary_key

  belongs_to :tablelist, foreign_key: :typetable, class_name: 'Tablelist'
  alias_attribute :tablelist_id, :typetable

  has_many :hw_peds, dependent: :restrict_with_error, foreign_key: 'type'

  def custom_hash
    serializable_hash(include: {
                        tablelist: { only: :title }
                      })
  end
end
