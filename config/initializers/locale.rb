I18n.load_path += Dir[Rails.root.join('lib', 'locale', '*.yml')]

I18n.available_locales = [:en, :pl]

I18n.default_locale = :en
