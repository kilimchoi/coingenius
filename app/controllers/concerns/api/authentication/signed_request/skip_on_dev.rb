module Api
  module Authentication
    module SignedRequest
      module SkipOnDev
        extend ActiveSupport::Concern

        included do
          with_options(if: -> { Rails.env.development? }) do
            # No need to authenticate user on dev
            skip_before_action :authenticate

            # Meantime we need to set +current_user+
            before_action :set_current_user_for_dev
          end
        end

        private

        def set_current_user_for_dev
          api_key = request.headers["HTTP_AUTHORIZATION"]&.split(":", 2)&.first

          @current_user = UserApiCredential.find_by(key: api_key)&.user

          @current_user || render(json: { error: "No user with this API key" }, status: :unauthorized)
        end
      end
    end
  end
end
