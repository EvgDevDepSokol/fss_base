class Selectors::HwIcsController < ApplicationController
  include SelectorControllerHelper

  def index
    @hw_ics = HwIc.where(Project: project.ProjectID).order(:ref)
    .pluck(:id, :ref)
    do_format(@hw_ics)
  end
end
