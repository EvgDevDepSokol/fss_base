# frozen_string_literal: true

class Selectors::PdsSectionAssemblersController < ApplicationController
  include SelectorControllerHelper

  def index
    @pds_section_assemblers = PdsSectionAssembler.where(Project: project.ProjectID).order(:section_name)
                                                 .pluck(:section_N, :section_name)
    do_format(@pds_section_assemblers)
  end
end
