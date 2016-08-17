class PdsMnemo < ActiveRecord::Base
  self.table_name = 'pds_mnemo'
  self.inheritance_column = nil

  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_project, foreign_key: 'Project'
  belongs_to :pds_detector, foreign_key: 'Detector'

  validates_presence_of :Code

  alias_attribute :system_id, :sys
  alias_attribute :pds_detector_id, :Detector

  def custom_hash
    serializable_hash(include: {
                        system: { only: [:System] },
                        pds_detector: { only: [:tag] }
                      })
  end
end
