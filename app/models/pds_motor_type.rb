class PdsMotorType < ActiveRecord::Base

  self.table_name = 'pds_motor_type'

  def custom_hash
    serializable_hash
  end

  def serializable_hash(options={})
    super options.merge(methods: :id)
  end

end
