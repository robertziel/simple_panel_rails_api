module Auth
  class ActiveTokensAPI < Grape::API
    before do
      authenticate!
    end

    helpers do
      def active_tokens
        @active_tokens ||= current_user.authentication_tokens.valid
      end
    end

    resource :active_tokens do
      include Grape::Kaminari

      desc 'Active tokens' do
        headers ApiDescHelper.with_common_headers
      end
      paginate
      get do
        status 200
        {
          authentication_tokens: serialize_collection(
            paginate(active_tokens), serializer: Api::Auth::ActiveTokenSerializer
          ),
          count: active_tokens.count
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
