class ApplicationController < ActionController::Base
  protect_from_forgery

  force_ssl

  private

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def user_signed_in?
    current_user.present?
  end

  def user_admin?
    if @current_user.role == "Administrator"
      return true
    else
      return false
    end
  end

  def require_login
    unless user_signed_in?
      redirect_to login_path, alert: "Bitte melden Sie sich zuerst an."
    end
  end

  def require_admin
    unless user_admin?
      redirect_to clients_path, alert: "Bitte melden Sie sich zuerst an."
    end
  end

  helper_method :require_admin
  helper_method :require_login
  helper_method :user_admin?
  helper_method :user_signed_in?
end
