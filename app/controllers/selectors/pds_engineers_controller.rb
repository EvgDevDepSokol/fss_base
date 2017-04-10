class Selectors::PdsEngineersController < ApplicationController
  include SelectorControllerHelper

  def index
    @pds_engineers = PdsEngineer.order(:name)
                                .pluck(:id, :name)
    do_format(@pds_engineers)
  end
end
