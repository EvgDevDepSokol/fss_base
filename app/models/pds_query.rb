class PdsQuery < ActiveRecord::Base
  belongs_to :pds_project, foreign_key: 'Project'
end
