class Article < ActiveRecord::Base
  self.table_name = 'news'

  def custom_hash
    serializable_hash.merge({id: id})
  end

end
