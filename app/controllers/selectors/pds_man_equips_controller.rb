# frozen_string_literal: true

class Selectors::PdsManEquipsController < ApplicationController
  include SelectorControllerHelper

  def index
    @pds_man_equips = PdsManEquip.order(:Type)
                                 .pluck(:EquipN, :Type)
    do_format(@pds_man_equips)
  end
end
