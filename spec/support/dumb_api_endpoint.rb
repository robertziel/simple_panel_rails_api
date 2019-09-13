class DumbApiEndpoint < Grape::API
  resource :dumb do
    get do
      status 200
      { locale: I18n.locale }
    end
  end
end
