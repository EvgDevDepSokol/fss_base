class Selectors::PdsUnitsController < ApplicationController
  include SelectorControllerHelper

  def index
    @pds_units = PdsUnit.order(:Unit_RU)
    .pluck(:UnitID, :Unit_RU)
    do_format(@pds_units)
  end
end
