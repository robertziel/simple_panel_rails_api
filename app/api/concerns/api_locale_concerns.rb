module ApiLocaleConcerns
  extend ActiveSupport::Concern
  extend Grape::API::Helpers

  included do
    helpers HelperMethods

    before do
      switch_locale
    end

    after do
      reset_locale
    end
  end

  module HelperMethods
    def switch_locale
      locale = request.headers[LANGUAGE_LOCALE_HEADER] || I18n.default_locale
      I18n.locale = locale
    end

    def reset_locale
      I18n.locale = I18n.default_locale
    end
  end
end
