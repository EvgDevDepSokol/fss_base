class Selectors::HwPedsController < ApplicationController
  include SelectorControllerHelper

  def index
    @hw_peds = HwPed.where(Project: project.ProjectID).order(:ped)
                    .pluck(:ped_N, :ped)
    do_format(@hw_peds)
  end
end
