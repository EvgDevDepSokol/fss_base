class Selectors::PdsDetectorsController < ApplicationController
  include SelectorControllerHelper
  before_action :project

  def index
    @pds_detectors = PdsDetector.where(Project: project.ProjectID).order(:tag)
                                .pluck(:DetID, :tag)
    do_format(@pds_detectors)
  end

end
