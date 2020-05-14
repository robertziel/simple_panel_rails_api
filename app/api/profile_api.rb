class ProfileAPI < Grape::API
  before do
    authenticate!
  end

  resource :profile do
    include Grape::Kaminari

    desc 'Index' do
      headers ApiDescHelper.with_common_headers
    end
    get do
      { profile: current_user.as_json(only: %i[email username]) }
    end
  end
end
