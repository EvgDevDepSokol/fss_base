class PdsValvesController < ApplicationController
  before_action :set_pds_valf, only: [:show]

  def index
    @pds_valves = PdsValf.all.order(:Type)
  end

  def show
  end

  private

  def set_pds_valf
    @pds_valf = PdsValf.find(params[:id])
  end
end
