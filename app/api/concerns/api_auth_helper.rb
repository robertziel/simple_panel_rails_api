module ApiAuthHelper
  extend ActiveSupport::Concern

  included do
    include HelperMethods
  end

  module HelperMethods
    def authenticate!
      error!(I18n.t('api.helpers.auth.authentication_error'), 401) unless current_user
    end

    def current_authentication_token
      @current_authentication_token ||= begin
        token = AuthenticationToken.valid.find_by_token(
          request.headers[AUTHENTICATION_TOKEN_HEADER]
        )
        token&.touch(:last_used_at)
        token
      end
    end

    def current_user
      @current_user ||= begin
        token = current_authentication_token
        token ? token.user : false
      end
    end
  end
end
