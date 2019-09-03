module Auth
  class SignOutAPI < BaseAPI
    helpers ApiAuthHelpers

    format :json

    before do
      authenticate!
    end

    resource :sign_out do
      desc 'Sign out' do
        headers GrapeSwaggerRails.options.authentication_token_header_docs
      end

      delete do
        current_authentication_token.expire!
        status 200
        { success: true }
      end
    end
  end
end
