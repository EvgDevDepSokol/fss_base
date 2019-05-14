# frozen_string_literal: true

class PdsIomap < ApplicationRecord
  self.table_name = 'pds_iomap'
  alias_attribute :id, primary_key

  def custom_hash
    serializable_hash
  end

  def serializable_hash(options = {})
    super options.merge(methods: :id)
  end
end
