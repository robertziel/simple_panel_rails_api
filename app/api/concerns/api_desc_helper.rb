module ApiDescHelper
  def self.with_common_headers(auth: true, headers: {})
    if auth
      headers.merge!(
        AUTHENTICATION_TOKEN_HEADER => {
          description: 'Authentication token',
          required: true
        }
      )
    end

    headers.merge!(
      LANGUAGE_LOCALE_HEADER => {
        description:
          "available: #{I18n.available_locales.join(', ')}, default: #{I18n.default_locale})"
      }
    )

    headers
  end
end
