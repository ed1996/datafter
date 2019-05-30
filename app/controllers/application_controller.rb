class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:last_name, :first_name, :date_birth, :avatar, :phone_number, :description, :email, :password, :password_confirmation])
  end

  before_action :set_search

  def set_search
    @q = current_user.hommages.ransack(params[:q])
    @hommages = @q.result(distinct: true)
  end
end
