# frozen_string_literal: true

class HwDevtype < ApplicationRecord
  self.table_name = 'hw_devtype'
  alias_attribute :id, primary_key

  belongs_to :tablelist, foreign_key: :typetable, class_name: 'Tablelist', inverse_of: :hw_devtypes
  alias_attribute :tablelist_id, :typetable

  has_many :hw_peds, dependent: :restrict_with_error, foreign_key: 'type', inverse_of: :hw_devtype

  def custom_hash
    serializable_hash(include: {
                        tablelist: { only: :title }
                      })
  end
end
