module Auth
  class SignOutAPI < BaseAPI
    helpers ApiAuthHelpers

    format :json

    before do
      authenticate!
    end

    resource :sign_out do
      desc 'Sign out'

      params do
        use :authentication_token
      end

      delete do
        current_authentication_token.expire!
        status 200
        { success: true }
      end
    end
  end
end
