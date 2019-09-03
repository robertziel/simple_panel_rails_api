class CurrentUserAPI < BaseAPI
  helpers ApiAuthHelpers

  format :json

  before do
    authenticate!
  end

  resource :current_user do
    desc 'Get current_user' do
      headers GrapeSwaggerRails.options.authentication_token_header_docs
    end

    get do
      { username: current_user.username }
    end
  end
end
