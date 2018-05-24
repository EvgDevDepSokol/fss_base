class SelectBuildersController < ApplicationController
  layout false
  def new
    # @select = ::SelectBuilder::Settings.new('type' => params[:type])
    @select = ::SelectBuilder::Settings.new('type' => 'pds_rf')
  end

  def create
    @select = ::SelectBuilder::Settings.new(params[:select_builder_settings])
    byebug
    #schedule
  end
end
