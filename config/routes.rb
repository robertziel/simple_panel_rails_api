Rails.application.routes.draw do
  namespace :api, path: '/api' do
    mount API::Base, at: '/'
    mount GrapeSwaggerRails::Engine => '/docs'
  end
end
