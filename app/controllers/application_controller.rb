class ApplicationController < ActionController::Base
  include ClientAppVariables

  before_action :current_account
  before_action :authenticate_user!
  helper_method :current_user
  helper_method :current_account

  ALLOWED_PATH_WITHOUT_LOGIN = ['/login', '/logout', '/registration']

  def authenticate_user!
    redirect_to login_path unless current_user || ALLOWED_PATH_WITHOUT_LOGIN.include?(request.path)
  end

  def current_user
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end

  def account_from_cname(cname)
    Account.enabled.find_by('default_helpdesk_url LIKE ?', "%#{cname}%")
  end

  def account_from_subdomain
    request.subdomain.presence && Account.find_by(subdomain: request.subdomain)
  end

  def detect_account
    account_from_cname(request.host) || account_from_subdomain
  end

  def current_account
    @current_account ||= current_user.try(:account) || detect_account || :false
    @current_account == :false ? nil : @current_account
  end
end
