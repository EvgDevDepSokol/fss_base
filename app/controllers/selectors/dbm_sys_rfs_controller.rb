class Selectors::DbmSysRfsController < ApplicationController
  include SelectorControllerHelper

  def index
    @dbm_sys_rfs = PdsRf.where(Project: project.ProjectID).includes(:system).order('pds_syslist.System').pluck('pds_syslist.SystemID', 'pds_syslist.System').uniq
    do_format(@dbm_sys_rfs)
  end
end
