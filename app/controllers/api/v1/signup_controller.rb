module Api
  module V1
    class SignupController < Api::V1::ApplicationController
      skip_before_action :authenticate, only: :create

      respond_to :json

      def create
        result = Api::V1::SignupUser.call(params: user_params)

        @user = result.user

        if @user.present?
          respond_with @user
        else
          render json: { error: result.message }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.fetch(:user, {}).permit(:email, :password, :username)
      end
    end
  end
end
