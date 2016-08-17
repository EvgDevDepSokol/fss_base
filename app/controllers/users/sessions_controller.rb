class Users::SessionsController < Devise::SessionsController
  # def create
  # custom sign-in code
  # end

  # def resource_params
  #  params.require(:user).permit(:login, :password, :remember_me)
  # end
  # private :resource_params
  #

  before_filter :configure_permitted_parameters

  def configure_permitted_parameters
    # devise_parameter_sanitizer.for(:sign_in).push(:login)
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login])
  end
end
