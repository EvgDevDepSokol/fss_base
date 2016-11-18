class PdsMotorType < ActiveRecord::Base
  self.table_name = 'pds_motor_type'

  has_many :pds_motors, dependent: :restrict_with_error, foreign_key: 'MotorType'

  def custom_hash
    serializable_hash
  end
end
