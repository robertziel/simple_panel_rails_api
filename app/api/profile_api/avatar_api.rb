class ProfileAPI
  class AvatarAPI < Grape::API
    resource :avatar do
      desc 'Show' do
        headers ApiDescHelper.with_common_headers
      end
      get do
        { avatar: current_user.decorate.avatar_or_default }
      end

      desc 'Update' do
        headers ApiDescHelper.with_common_headers
      end
      params do
        requires :avatar, type: File, desc: 'New avatar'
      end
      post do
        user = current_user
        avatar_params = {
          filename: params[:avatar][:filename],
          io: params[:avatar][:tempfile]
        }

        if user.update(avatar: avatar_params)
          status 200
          { avatar: user.decorate.avatar_or_default }
        else
          response_json = {
            error_message: user.errors.messages.transform_values { |value| value.join(', ') }
          }
          error!(response_json, 200)
        end
      end
    end
  end
end
