class Selectors::PdsSysDescriptionsController < ApplicationController
  include SelectorControllerHelper

  def index
    @pds_sys_descriptions = PdsSysDescription.where(Project: project.ProjectID).includes(:system).order('pds_syslist.System')
                                             .pluck(:sys, 'pds_syslist.System')
    do_format(@pds_sys_descriptions)
  end
end
