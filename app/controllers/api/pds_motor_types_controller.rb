class Api::PdsMotorTypesController < ApplicationController
  before_action :set_pds_motor_type, only: [:show]

  def index
    @pds_motor_types = PdsMotorType.all
  end

  def show
  end

  private

  def set_pds_motor_type
    @pds_motor_type = PdsMotorType.find(params[:id])
  end
end
