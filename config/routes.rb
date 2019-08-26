Rails.application.routes.draw do
  namespace :api, path: '/api' do
    mount RootAPI, at: '/'
    mount GrapeSwaggerRails::Engine => '/docs'
  end
end
