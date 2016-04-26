class Api::PdsEngineersController < ApplicationController
  def index
    @pds_engineers = PdsEngineer.all
  end
end
