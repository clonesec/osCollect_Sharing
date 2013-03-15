class ApplicationController < ActionController::Base
  # protect_from_forgery

  private

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
