class RootAPI < Grape::API
  namespace :auth do
    mount Auth::SignInAPI
  end
  mount WelcomeAPI

  add_swagger_documentation(
    hide_documentation_path: true,
    mount_path: '/swagger_doc',
    hide_format: true
  )
end
