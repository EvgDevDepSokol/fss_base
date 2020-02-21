# frozen_string_literal: true

# Project. Contains copy/destroy all project objets procedures
class PdsProject < ApplicationRecord
  self.table_name = 'pds_project'
  include EquipmentPanelsHelper
  alias_attribute :id, primary_key
  belongs_to :company, foreign_key: :companyID, inverse_of: :pds_project
  has_one :project_properties, foreign_key: :ProjectID, class_name: 'PdsProjectProperty', inverse_of: :pds_project
  has_many :hw_ic, dependent: :restrict_with_error, foreign_key: 'Project', inverse_of: :pds_project

  def name
    project_name
  end

  def custom_hash
    serializable_hash.merge(id: id)
  end
end
