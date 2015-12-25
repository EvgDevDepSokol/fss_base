json.array!(@pds_motor_types) do |pds_motor_type|
  json.extract! pds_motor_type, :id, :MotorType
end
