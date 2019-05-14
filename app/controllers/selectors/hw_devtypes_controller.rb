# frozen_string_literal: true

class Selectors::HwDevtypesController < ApplicationController
  include SelectorControllerHelper

  def index
    @hw_devtypes = HwDevtype.order(:RuName)
                            .pluck(:id, :RuName)
    do_format(@hw_devtypes)
  end
end
