# frozen_string_literal: true

class PdsMathmodel < ApplicationRecord
  self.table_name = 'pds_mathmodel'
  alias_attribute :id, primary_key
end
