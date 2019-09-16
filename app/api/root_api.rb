class RootAPI < Grape::API
  helpers ApiAuthHelper
  include ApiLocaleConcerns

  format :json

  namespace :auth do
    mount Auth::SignInAPI
    mount Auth::SignOutAPI
  end
  mount CurrentUserAPI
  mount UsersAPI
  mount WelcomeAPI

  add_swagger_documentation(
    hide_documentation_path: true,
    mount_path: '/swagger_doc',
    hide_format: true
  )
end
