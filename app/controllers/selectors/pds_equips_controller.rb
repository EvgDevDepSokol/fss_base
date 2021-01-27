# frozen_string_literal: true

class Selectors::PdsEquipsController < ApplicationController
  include SelectorControllerHelper

  def index
    @pds_equips = PdsEquip.order(:typeE).pluck(:TEquipID, :typeE)
    do_format(@pds_equips)
  end
end
