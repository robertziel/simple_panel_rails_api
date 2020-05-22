module Auth
  class ActiveTokensAPI < Grape::API
    before do
      authenticate!
    end

    resource :active_tokens do
      desc 'Index' do
        headers ApiDescHelper.with_common_headers
      end

      get do
        active_tokens = current_user.authentication_tokens.valid

        status 200
        {
          active_tokens: serialize_collection(
            active_tokens, serializer: Api::Auth::ActiveTokenSerializer
          )
        }
      end
    end
  end
end
