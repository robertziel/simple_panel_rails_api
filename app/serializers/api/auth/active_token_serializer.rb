module Api
  module Auth
    class ActiveTokenSerializer < ApplicationSerializer
      attributes :id, :ip, :last_used_at, :expires_at, :created_at, :browser, :platform

      def ip
        object.ip.to_s
      end

      def last_used_at
        I18n.l(object.last_used_at)
      end

      def expires_at
        I18n.l(object.expires_at)
      end

      def created_at
        I18n.l(object.created_at)
      end

      def browser
        browser_object.name
      end

      def platform
        browser_object.platform.name
      end

      private

      def browser_object
        @browser_object ||= Browser.new(object.browser)
      end
    end
  end
end
