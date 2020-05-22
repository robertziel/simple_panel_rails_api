module Auth
  class ActiveTokensAPI < Grape::API
    before do
      authenticate!
    end

    helpers do
      def active_tokens
        current_user.authentication_tokens.valid
      end
    end

    resource :active_tokens do
      desc 'Index' do
        headers ApiDescHelper.with_common_headers
      end
      get do
        status 200
        {
          active_tokens: serialize_collection(
            active_tokens, serializer: Api::Auth::ActiveTokenSerializer
          )
        }
      end

      desc 'Expire tokens' do
        headers ApiDescHelper.with_common_headers
      end
      params do
        requires :ids, type: Array[Integer], desc: 'Remove authentication tokens'
      end
      post do
        active_tokens.find(params[:ids]).each(&:expire!)
        status 200
        { success: true }
      end
    end
  end
end
