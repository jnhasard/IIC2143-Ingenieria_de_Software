class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def user_params
	params.require(:user).permit(:email, :username, :tipo, :image_file_name, :image_content_type, :image_file_size, :image_updated_at)  # titulo y cuerpo son permitidos, nada más
  end

  protected

  def configure_permitted_parameters
  	devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :username, :tipo])
  	devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :username, :tipo])
  end
  def is_comun_user?
    user_signed_in? && current_user.is_comun_user?
  end
  def authenticate_mod!
    redirect_to root_path unless user_signed_in? && current_user.is_mod_user?
  end
  def authenticate_admin!
    redirect_to root_path unless user_signed_in? && current_user.is_admin_user?
  end

end
