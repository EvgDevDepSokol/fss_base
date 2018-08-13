class Selectors::DbmSysMfsController < ApplicationController
  include SelectorControllerHelper

  def index
    @dbm_sys_mfs = PdsMalfunction.where(Project: project.ProjectID).includes(:system).order('pds_syslist.System').pluck('pds_syslist.SystemID', 'pds_syslist.System').uniq
    do_format(@dbm_sys_mfs)
  end
end
