module Api
  module Authentication
    module SignedRequest
      extend ActiveSupport::Concern

      included do
        before_action :authenticate
      end

      def authenticate
        result = Authenticator.call(request: request)

        if result.success?
          @current_user = result.user
        else
          render json: { error: result.message}, status: :unauthorized
        end
      end
    end
  end
end
