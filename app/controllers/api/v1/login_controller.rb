module Api
  module V1
    class LoginController < Api::V1::ApplicationController
      skip_before_action :authenticate, only: :create

      respond_to :json

      def create
        user = User.find_by(email: user_params[:email])

        if user&.valid_password?(user_params[:password])
          render json: { api_key: user.api_key, api_secret: user.api_secret }
        else
          fail_attempt!
        end
      rescue ActionController::ParameterMissing
        fail_attempt!
      end

      private

      def fail_attempt!
        head :unauthorized
      end

      def user_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
