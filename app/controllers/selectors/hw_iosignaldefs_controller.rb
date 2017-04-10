class Selectors::HwIosignaldefsController < ApplicationController
  include SelectorControllerHelper

  def index
    @hw_iosignaldefs = HwIosignaldef.order(:ioname).
      pluck(:id, :ioname)
    do_format(@hw_iosignaldefs)
  end
end
