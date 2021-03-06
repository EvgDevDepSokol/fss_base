# frozen_string_literal: true

# table with project news
class Article < ApplicationRecord
  self.table_name = 'news'
  alias_attribute :id, primary_key

  def custom_hash
    serializable_hash.merge(id: id)
  end
end
