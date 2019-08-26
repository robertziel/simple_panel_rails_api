module API
  class Root < Grape::API
    namespace :auth do
      mount Auth::SignIn
    end
    mount Welcome

    add_swagger_documentation(
      hide_documentation_path: true,
      mount_path: '/swagger_doc',
      hide_format: true
    )
  end
end
