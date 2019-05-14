# frozen_string_literal: true

class Tablelist < ApplicationRecord
  self.table_name = 'tablelist'
  alias_attribute :id, primary_key
  def custom_hash
    serializable_hash.merge(id: id)
  end
end
