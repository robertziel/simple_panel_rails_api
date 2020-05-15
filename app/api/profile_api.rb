class ProfileAPI < Grape::API
  before do
    authenticate!
  end

  resource :profile do
    include Grape::Kaminari

    desc 'Index' do
      headers ApiDescHelper.with_common_headers
    end
    get do
      { profile: current_user.as_json(only: %i[email username]) }
    end

    desc 'Update' do
      headers ApiDescHelper.with_common_headers
    end
    params do
      requires :username, type: String, desc: 'Username'
      requires :email, type: String, desc: 'User email'
    end
    post do
      user = current_user
      if user.update(declared(params))
        status 200
        { profile: user.as_json(only: %i[email username]) }
      else
        response_json = {
          error_message: I18n.t('api.auth.sign_in.email_or_password_wrong')
        }
        error!(response_json, 401)
      end
    end
  end
end
