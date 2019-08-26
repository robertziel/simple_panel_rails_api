Rails.application.routes.draw do
  namespace :api, path: '/api' do
    mount API::Root, at: '/'
    mount GrapeSwaggerRails::Engine => '/docs'
  end
end
