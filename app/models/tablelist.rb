# frozen_string_literal: true

class Tablelist < ApplicationRecord
  self.table_name = 'tablelist'
  has_many :hw_devtypes, dependent: :restrict_with_error, foreign_key: 'typetable', inverse_of: :tablelist
  alias_attribute :id, primary_key
  def custom_hash
    serializable_hash.merge(id: id)
  end
end
