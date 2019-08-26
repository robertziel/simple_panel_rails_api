module API
  class Root < Grape::API
    mount Auth::SignIn => '/auth'
    mount Welcome

    add_swagger_documentation(
      hide_documentation_path: true,
      mount_path: '/swagger_doc',
      hide_format: true
    )
  end
end
