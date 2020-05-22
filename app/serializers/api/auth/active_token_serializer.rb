module Api
  module Auth
    class ActiveTokenSerializer < ApplicationSerializer
      attributes :id, :ip

      def ip
        object.ip.to_s
      end
    end
  end
end
