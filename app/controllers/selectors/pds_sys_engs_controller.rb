# frozen_string_literal: true

class Selectors::PdsSysEngsController < ApplicationController
  include SelectorControllerHelper

  def index
    @pds_sys_engs = PdsEngOnSy.where(project: project.ProjectID)
                              .includes(:pds_engineer, :system)
                              .order('pds_syslist.System')
                              .pluck(:sys, 'pds_syslist.System', 'pds_engineers.name')
                              .each.map do |e|
      e1 = {}
      e1[0] = e[0]
      e1[1] = e[1] + ' ' + e[2]
      e = e1
    end

    do_format(@pds_sys_engs)
  end
end
