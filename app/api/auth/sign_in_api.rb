module Auth
  class SignInAPI < BaseAPI
    format :json

    resource :sign_in do
      desc 'Sign in'

      params do
        requires :email, type: String, desc: 'User email'
        requires :password, type: String, desc: 'User password'
      end

      post '' do
        user = User.find_by_email(params[:email])
        if user&.authenticate(params[:password])
          authentication_token = user.authentication_tokens.create!

          status 200
          { authentication_token: authentication_token.token }
        else
          response_json = {
            error_message: 'Email or password are wrong'
          }
          error!(response_json, 401)
        end
      end
    end
  end
end
