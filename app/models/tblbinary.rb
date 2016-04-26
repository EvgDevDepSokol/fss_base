class Tblbinary < ActiveRecord::Base
  self.table_name = 'tblbinaries'

  def serializable_hash(_options = {})
    super(except: :binObj)
  end

  def custom_hash
    serializable_hash.merge(id: id, link: Rails.application.routes.url_helpers.get_file_tblbinary_path(id))
  end
end
