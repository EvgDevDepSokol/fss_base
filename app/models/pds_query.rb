# frozen_string_literal: true

class PdsQuery < ApplicationRecord
  alias_attribute :id, primary_key
  belongs_to :pds_project, foreign_key: 'Project'
end
