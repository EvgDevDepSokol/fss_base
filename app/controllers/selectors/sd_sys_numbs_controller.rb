# frozen_string_literal: true

class Selectors::SdSysNumbsController < ApplicationController
  include SelectorControllerHelper

  def index
    @sd_sys_numbs = SdSysNumb.where(Project: project.ProjectID).order(:sd_link)
                             .pluck(:sd_N, :sd_link)
    do_format(@sd_sys_numbs)
  end
end
