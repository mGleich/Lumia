class PagesController < ApplicationController
  force_ssl
  before_filter :require_login
  layout "admin"
  def index
  end

  before_filter :require_admin
  layout "admin"
  def admin_menu
  end

  private

  def require_login
    unless user_signed_in?
      redirect_to login_path, alert: "Bitte melden Sie sich zuerst an."
    end
  end
end
