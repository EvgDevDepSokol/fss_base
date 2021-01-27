# frozen_string_literal: true

class Selectors::PdsPanelsController < ApplicationController
  include SelectorControllerHelper

  def index
    @pds_panels = PdsPanel.where(Project: project.ProjectID).order(:panel)
                          .pluck(:pID, :panel)
    do_format(@pds_panels)
  end
end
