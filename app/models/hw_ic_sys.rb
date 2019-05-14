# frozen_string_literal: true

class HwIcSys < ApplicationRecord
  self.table_name = 'hw_ic_sys'
  alias_attribute :id, primary_key
end
