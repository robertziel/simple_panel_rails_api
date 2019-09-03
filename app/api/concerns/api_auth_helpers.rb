module ApiAuthHelpers
  extend ActiveSupport::Concern
  extend Grape::API::Helpers

  included do
    include HelperMethods
  end

  params :authentication_token do
    requires :authentication_token, type: String, desc: 'Authentication token'
  end

  module HelperMethods
    def authenticate!
      error!('Unauthorized. Invalid or expired token.', 401) unless current_user
    end

    def current_user
      @current_user ||= begin
        token = AuthenticationToken.valid.find_by_token(params[:authentication_token])
        token ? token.user : false
      end
    end
  end
end
