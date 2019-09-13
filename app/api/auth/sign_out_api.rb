module Auth
  class SignOutAPI < Grape::API
    before do
      authenticate!
    end

    resource :sign_out do
      desc 'Sign out' do
        headers ApiDescHelper.with_common_headers
      end

      delete do
        current_authentication_token.expire!
        status 200
        { success: true }
      end
    end
  end
end
