class ProfileAPI < Grape::API
  before do
    authenticate!
  end

  resource :profile do
    mount AvatarAPI

    desc 'Show' do
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
      optional :password, type: String, desc: 'New password'
      optional :password_confirmation, type: String, desc: 'Confirm new password'
    end
    post do
      user = current_user
      user_attributes = declared(params)
      # remove password from user_attributes if blank
      if user_attributes[:password].blank?
        user_attributes.except!(:password, :password_confirmation)
      else
        user_attributes[:password] = user_attributes[:password] || ''
        user_attributes[:password_confirmation] = user_attributes[:password_confirmation] || ''
      end

      if user.update(user_attributes)
        status 200
        { profile: user.as_json(only: %i[email username]) }
      else
        response_json = {
          error_messages: user.errors.messages.transform_values { |value| value.join(', ') }
        }
        error!(response_json, 200)
      end
    end
  end
end
