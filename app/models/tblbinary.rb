# frozen_string_literal: true

class Tblbinary < ApplicationRecord
  self.table_name = 'tblbinaries'
  alias_attribute :id, primary_key

  def serializable_hash(_options = {})
    super(except: :binObj)
  end

  def custom_hash
    serializable_hash.merge(id: id, link: Rails.application.routes.url_helpers.get_file_tblbinary_path(id))
  end
end
