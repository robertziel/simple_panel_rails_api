class CurrentUserAPI < BaseAPI
  helpers ApiAuthHelpers

  format :json

  before do
    authenticate!
  end

  resource :current_user do
    desc 'Get current_user'

    params do
      use :authentication_token
    end

    get do
      { username: current_user.username }
    end
  end
end
