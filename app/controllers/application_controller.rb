# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Main application controller
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  def after_sign_in_path_for(_resource, *_args)
    # options  = args.extract_options!
    if params['user'] && (params['user']['login_project'])
      tmp = params['user']['login_project']
      '/pds_projects/' + tmp + '/hw_ics'
    else
      ''
    end
  end
end
