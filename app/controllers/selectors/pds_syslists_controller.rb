# frozen_string_literal: true

class Selectors::PdsSyslistsController < ApplicationController
  include SelectorControllerHelper

  def index
    @pds_syslists = PdsSyslist.order(:System).pluck(:SystemID, :System)
    do_format(@pds_syslists)
  end
end
