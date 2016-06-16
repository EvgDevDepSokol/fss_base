class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  def after_sign_in_path_for(resource, *args)
    #options  = args.extract_options!  
    tmp=self.params['user']['login_project']
    '/pds_projects/'+tmp+'/hw_ics'
  end  
end
