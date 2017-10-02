module Api
  module V1
    class SignupUser
      include Interactor

      delegate :params, to: :context

      before do
        context.fail!(message: "User already exists") if user_exists?
      end

      def call
        context.user = User.create(params)

        context.fail! if context.user.errors.any?

        context.user.create_user_api_credential!
      end

      private

      def user_exists?
        User.exists?(email: params[:email])
      end
    end
  end
end
