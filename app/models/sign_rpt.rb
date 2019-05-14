# frozen_string_literal: true

class SignRpt < ApplicationRecord
  self.table_name = 'sign_rpt'
  alias_attribute :id, primary_key
  def custom_hash
    serializable_hash.merge(id: id)
  end
end
