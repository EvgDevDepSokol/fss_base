# frozen_string_literal: true

class Selectors::PdsDetectorsController < ApplicationController
  include SelectorControllerHelper

  def index
    @pds_detectors = PdsDetector.where(Project: project.ProjectID)
                                .where.not(tag: '')
                                .order(:tag)
                                .pluck(:DetID, :tag)
    do_format(@pds_detectors)
  end
end
