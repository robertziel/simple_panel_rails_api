Rails.application.routes.draw do
  root 'welcome#index'
  namespace :api, path: '/api' do
    mount RootAPI, at: '/'
    mount GrapeSwaggerRails::Engine => '/docs'
  end
end
