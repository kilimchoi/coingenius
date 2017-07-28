module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def coinbase
      # Do not allow registration via Coinbase. We allow only linking Coinbase account to an existing User
      redirect_to new_user_registration_path if current_user.blank?

      # Link current User to a newly created Coinbase identity
      identity.update(user: current_user) if identity.user.blank?

      # Immediately enqueue syncing user Coinbase buys and sells
      Users::Coinbase::SyncBuysForUserWorker.perform_async(current_user.id)
      Users::Coinbase::SyncSellsForUserWorker.perform_async(current_user.id)

      redirect_to "/portfolio", notice: "You have successfully connected to your Coinbase account."
    end

    private

    def auth
      request.env["omniauth.auth"]
    end

    def after_omniauth_failure_path_for(_scope)
      "/portfolio"
    end

    def identity
      @identity ||= Identity.find_or_create_with_omniauth(auth)
    end
  end
end
