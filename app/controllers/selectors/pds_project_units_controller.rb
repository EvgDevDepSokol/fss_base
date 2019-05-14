# frozen_string_literal: true

class Selectors::PdsProjectUnitsController < ApplicationController
  include SelectorControllerHelper

  def index
    @pds_project_units = PdsProjectUnit.where(Project: project.ProjectID).includes(:unit)
                                       .order('pds_unit.Unit_RU')
                                       .pluck(:ProjUnitID, 'pds_unit.Unit_RU')
    do_format(@pds_project_units)
  end
end
