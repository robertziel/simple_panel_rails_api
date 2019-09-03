module ApiAuthHelpers
  extend ActiveSupport::Concern
  extend Grape::API::Helpers

  included do
    include HelperMethods
  end

  module HelperMethods
    def authenticate!
      error!('Unauthorized. Invalid or expired token.', 401) unless current_user
    end

    def current_authentication_token
      @current_authentication_token ||=
        AuthenticationToken.valid.find_by_token(request.headers['Authentication-Token'])
    end

    def current_user
      @current_user ||= begin
        token = current_authentication_token
        token ? token.user : false
      end
    end
  end
end
