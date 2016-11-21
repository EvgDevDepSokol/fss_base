class PdsSectionAssembler < ActiveRecord::Base
  self.table_name = 'pds_section_assembler'
  belongs_to :pds_project, foreign_key: 'Project'

  has_many :pds_announciator, dependent: :restrict_with_error, foreign_key: 'ctrl_power'
  has_many :pds_breakers_ed, dependent: :restrict_with_error, foreign_key: 'ed_power', class_name: 'PdsBreaker'
  has_many :pds_breakers_ctrl, dependent: :restrict_with_error, foreign_key: 'ctrl_power', class_name: 'PdsBreaker'
  has_many :pds_breakers_anc, dependent: :restrict_with_error, foreign_key: 'anc_power', class_name: 'PdsBreaker'
  has_many :pds_bru, dependent: :restrict_with_error, foreign_key: 'ctrl_power'
  has_many :pds_buttons_lights, dependent: :restrict_with_error, foreign_key: 'ctrl_power'
  has_many :pds_detectors, dependent: :restrict_with_error, foreign_key: 'ctrl_power'
  has_many :pds_lamps, dependent: :restrict_with_error, foreign_key: 'ctrl_power'
  has_many :pds_meters, dependent: :restrict_with_error, foreign_key: 'ctrl_power'
  has_many :pds_meters_channels, dependent: :restrict_with_error, foreign_key: 'ctrl_power'
  has_many :pds_meters_digital, dependent: :restrict_with_error, foreign_key: 'ctrl_power'
  has_many :pds_misc, dependent: :restrict_with_error, foreign_key: 'ctrl_power'
  has_many :pds_motors_ed, dependent: :restrict_with_error, foreign_key: 'ed_power', class_name: 'PdsMotor'
  has_many :pds_motors, dependent: :restrict_with_error, foreign_key: 'power_section', class_name: 'PdsMotor'
  has_many :pds_motors_anc, dependent: :restrict_with_error, foreign_key: 'anc_power', class_name: 'PdsMotor'
  has_many :pds_motors_ctrl, dependent: :restrict_with_error, foreign_key: 'ctrl_power', class_name: 'PdsMotor'
  has_many :pds_recorders, dependent: :restrict_with_error, foreign_key: 'ctrl_power'
  has_many :pds_regulators_ed, dependent: :restrict_with_error, foreign_key: 'ed_power', class_name: 'PdsRegulator'
  has_many :pds_regulators_ctrl, dependent: :restrict_with_error, foreign_key: 'ctrl_power', class_name: 'PdsRegulator'
  has_many :pds_regulators_anc, dependent: :restrict_with_error, foreign_key: 'anc_power', class_name: 'PdsRegulator'
  has_many :pds_valves_ed, dependent: :restrict_with_error, primary_key: 'section_N', foreign_key: 'ed_power', class_name: 'PdsValf'
  has_many :pds_valves, dependent: :restrict_with_error, foreign_key: 'power_section'
  has_many :pds_valves_anc, dependent: :restrict_with_error, primary_key: 'section_N', foreign_key: 'anc_power', class_name: 'PdsValf'
  has_many :pds_valves_ctrl, dependent: :restrict_with_error, primary_key: 'section_N', foreign_key: 'ctrl_power', class_name: 'PdsValf'

  def custom_hash
    serializable_hash.merge(id: id)
  end
end
