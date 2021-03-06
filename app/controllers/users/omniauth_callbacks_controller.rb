module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def coinbase
      # Do not allow registration via Coinbase. We allow only linking Coinbase account to an existing User
      if current_user.blank?
        redirect_to new_user_registration_path
        return
      end

      # Link current User to a newly created Coinbase identity
      identity.update(user: current_user) if identity.user.blank?

      # If identity user and current user are different entities we assume that someone tries to connect the
      # same Coinbase account to a different CoinGenius accounts.
      # We want to avoid it
      if identity.user != current_user
        redirect_to "/portfolio", alert: "You have already connected to Coinbase using a different CoinGenius account."
      else
        # Update access and refresh tokens on every login (eg for a changed scopes)
        tokens = {
          refresh_token: auth.credentials.refresh_token,
          access_token: auth.credentials.token
        }.compact

        identity.update(tokens)

        # Immediately enqueue syncing user Coinbase buys and sells
        Users::Coinbase::SyncBuysForUserWorker.perform_async(current_user.id)
        Users::Coinbase::SyncSellsForUserWorker.perform_async(current_user.id)
        Users::Coinbase::SyncDepositsForUserWorker.perform_async(current_user.id)
        Users::Coinbase::SyncWithdrawalsForUserWorker.perform_async(current_user.id)
        Users::Coinbase::SyncSentForUserWorker.perform_async(current_user.id)
        Users::Coinbase::SyncReceivedForUserWorker.perform_async(current_user.id)
        redirect_to "/portfolio", notice: "You have successfully connected to your Coinbase wallet. We will be pulling your transactions soon."
      end
    end

    private

    def auth
      request.env["omniauth.auth"]
    end

    def failure_message
      "Sorry, oauth login failed. Please try again."
    end

    def after_omniauth_failure_path_for(_scope)
      "/portfolio"
    end

    def identity
      @identity ||= Identity.find_or_create_with_omniauth(auth)
    end
  end
end
