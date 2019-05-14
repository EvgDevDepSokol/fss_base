# frozen_string_literal: true

class PdsMotorType < ApplicationRecord
  self.table_name = 'pds_motor_type'
  alias_attribute :id, primary_key

  has_many :pds_motors, dependent: :restrict_with_error, foreign_key: 'MotorType'

  def custom_hash
    serializable_hash
  end
end
