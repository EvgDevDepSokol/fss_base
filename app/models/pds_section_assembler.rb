class PdsSectionAssembler < ActiveRecord::Base
  self.table_name = 'pds_section_assembler'
  belongs_to :pds_project, foreign_key: 'Project'

  has_many :pds_air_valves, dependent: :restrict_with_error, foreign_key: 'ctrl_power'
  has_many :pds_announciator, dependent: :restrict_with_error, foreign_key: 'ctrl_power'
  has_many :pds_breakers, dependent: :restrict_with_error, foreign_key: 'ed_power'
  has_many :pds_breakers, dependent: :restrict_with_error, foreign_key: 'ctrl_power'
  has_many :pds_breakers, dependent: :restrict_with_error, foreign_key: 'anc_power'
  has_many :pds_bru, dependent: :restrict_with_error, foreign_key: 'ctrl_power'
  has_many :pds_buttons_lights, dependent: :restrict_with_error, foreign_key: 'ctrl_power'
  has_many :pds_detectors, dependent: :restrict_with_error, foreign_key: 'ctrl_power'
  has_many :pds_lamps, dependent: :restrict_with_error, foreign_key: 'ctrl_power'
  has_many :pds_meters, dependent: :restrict_with_error, foreign_key: 'ctrl_power'
  has_many :pds_meters_channels, dependent: :restrict_with_error, foreign_key: 'ctrl_power'
  has_many :pds_meters_digital, dependent: :restrict_with_error, foreign_key: 'ctrl_power'
  has_many :pds_misc, dependent: :restrict_with_error, foreign_key: 'ctrl_power'
  has_many :pds_motors, dependent: :restrict_with_error, foreign_key: 'ed_power'
  has_many :pds_motors, dependent: :restrict_with_error, foreign_key: 'power_section'
  has_many :pds_motors, dependent: :restrict_with_error, foreign_key: 'anc_power'
  has_many :pds_motors, dependent: :restrict_with_error, foreign_key: 'ctrl_power'
  has_many :pds_recorders, dependent: :restrict_with_error, foreign_key: 'ctrl_power'
  has_many :pds_regulators, dependent: :restrict_with_error, foreign_key: 'ed_power'
  has_many :pds_regulators, dependent: :restrict_with_error, foreign_key: 'ctrl_power'
  has_many :pds_regulators, dependent: :restrict_with_error, foreign_key: 'anc_power'
  has_many :pds_valves, dependent: :restrict_with_error, foreign_key: 'ed_power'
  has_many :pds_valves, dependent: :restrict_with_error, foreign_key: 'power_section'
  has_many :pds_valves, dependent: :restrict_with_error, foreign_key: 'anc_power'
  has_many :pds_valves, dependent: :restrict_with_error, foreign_key: 'ctrl_power'

  def custom_hash
    serializable_hash.merge(id: id)
  end
end
