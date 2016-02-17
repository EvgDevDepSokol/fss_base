class SelectBuildersController < ApplicationController

  layout false
  def new
    @select = ::SelectBuilder::Settings.new('type' => params[:type])
  end

  def create
    @select = ::SelectBuilder::Settings.new(params[:select])
  # schedule
  end

end

