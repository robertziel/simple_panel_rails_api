module API
  class Welcome < Base
    format :json

    resource :welcome do
      desc 'Welcome endpoint'
      get '' do
        { title: 'Welcome to Sample Panel Rails API',
          message: 'Check repo: https://github.com/robertziel/simple_panel_rails_backend' }
      end
    end
  end
end
