class WelcomeAPI < Grape::API
  resource :welcome do
    desc 'Welcome endpoint' do
      headers ApiDescHelper.with_common_headers(auth: false)
    end

    get do
      { title: I18n.t('api.welcome.title'),
        message: I18n.t('api.welcome.message') }
    end
  end
end
