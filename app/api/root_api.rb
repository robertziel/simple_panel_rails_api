class RootAPI < Grape::API
  namespace :auth do
    mount Auth::SignInAPI
    mount Auth::SignOutAPI
  end
  mount CurrentUserAPI
  mount WelcomeAPI

  add_swagger_documentation(
    hide_documentation_path: true,
    mount_path: '/swagger_doc',
    hide_format: true
  )
end
