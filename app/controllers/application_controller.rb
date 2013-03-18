class ApplicationController < ActionController::Base
  # protect_from_forgery

  private

  def current_user_is_an_app_admin?
    false
  end
  helper_method :current_user_is_admin?

  def current_user_is_not_an_app_admin?
    true
  end
  helper_method :current_user_is_not_an_app_admin?

  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user

  def authenticate_user!
    if current_user.nil?
      if request.url =~ /login/i || request.url =~ /logout/i
        session[:ref] = nil
      else
        session[:ref] = request.url
      end
      redirect_to login_url, :alert => "You must first log in to access this page!"
    end
  end

  def restrict_access
    access_token_valid = true
    authenticate_or_request_with_http_token do |token, options|
      # ApiKey.exists?(access_token: token)
      if access_token_valid && (request.user_agent.downcase == 'oscollect')
        # cls: doing a "return true/false" does not work!
        true
      else
        false
      end
    end
    # cls: this causes a double render error:
    # realm = "osCollect"
    # self.headers["WWW-Authenticate"] = %(Token realm="#{realm}")
    # self.__send__ :render, json: {}, :status => :unauthorized
  end
end
