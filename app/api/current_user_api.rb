class CurrentUserAPI < Grape::API
  before do
    authenticate!
  end

  resource :current_user do
    desc 'Get current_user' do
      headers ApiDescHelper.with_common_headers
    end

    get do
      { username: current_user.username }
    end
  end
end
