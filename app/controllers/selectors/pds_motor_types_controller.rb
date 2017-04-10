class Selectors::PdsMotorTypesController < ApplicationController
  include SelectorControllerHelper

  def index
    @pds_motor_types = PdsMotorType.order(:MotorType)
    .pluck(:id, :MotorType)
    do_format(@pds_motor_types)
  end
end
