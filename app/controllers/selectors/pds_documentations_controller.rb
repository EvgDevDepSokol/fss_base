# frozen_string_literal: true

class Selectors::PdsDocumentationsController < ApplicationController
  include SelectorControllerHelper

  def index
    @pds_documentations = PdsDocumentation.where(Project: project.ProjectID).order(:DocTitle)
                                          .pluck(:id, :DocTitle)
    do_format(@pds_documentations)
  end
end
