class PdsAnnounciator < ActiveRecord::Base
  self.table_name = 'pds_announciator'
  self.inheritance_column = nil

  belongs_to :hw_ic, foreign_key: 'IC'
  belongs_to :system, foreign_key: :sys, class_name: 'PdsSyslist'
  belongs_to :pds_project, foreign_key: 'Project'
  belongs_to :pds_section_assembler, foreign_key: 'ctrl_power'
  belongs_to :pds_detector, foreign_key: 'Detector'

  alias_attribute :hw_ic_id, :IC
  alias_attribute :system_id, :sys
  alias_attribute :pds_section_assembler_id, :ctrl_power
  alias_attribute :pds_detector_id, :Detector

  schema_validations

  validates :Type, inclusion: %w(AN YC), allow_nil: true
  validates :sign, inclusion:  %w(предупр. авар.), allow_nil: true

  def custom_map
    true
  end

  def custom_hash
    serializable_hash(include: {
                        hw_ic: { only: [:ref, :tag_no, :Description], include: { hw_ped: { only: [:ped] } } },
                        system: { only: [:System] },
                        pds_section_assembler: { only: [:section_name] },
                        pds_detector: { only: [:tag] } })
  end
end
