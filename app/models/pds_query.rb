class PdsQuery < ActiveRecord::Base
  alias_attribute :id, primary_key
  belongs_to :pds_project, foreign_key: 'Project'
end
