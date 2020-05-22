module Auth
  class SignInAPI < Grape::API
    resource :sign_in do
      desc 'Sign in' do
        headers ApiDescHelper.with_common_headers(auth: false)
      end

      params do
        requires :email, type: String, desc: 'User email'
        requires :password, type: String, desc: 'User password'
      end

      post do
        user = User.find_by_email(params[:email])
        if user&.authenticate(params[:password])
          authentication_token = user.authentication_tokens.create!(
            ip: request.ip,
            browser: request.env['HTTP_USER_AGENT']
          )

          status 200
          { authentication_token: authentication_token.token }
        else
          response_json = {
            error_message: I18n.t('api.auth.sign_in.email_or_password_wrong')
          }
          error!(response_json, 401)
        end
      end
    end
  end
end
