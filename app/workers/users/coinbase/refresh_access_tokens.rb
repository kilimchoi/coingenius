module Users
  module Coinbase
    class RefreshAccessTokens
      include Sidekiq::Worker

      def perform
        Identity.where(provider: :coinbase).find_each do |identity|
          # Init client with an existing refresh token
          begin 
            client = ::Coinbase::Wallet::OAuthClient.new(
              access_token: identity.access_token,
              refresh_token: identity.refresh_token
            )

            # Refresh an access token
            client.refresh!

            # Save new tokens
            identity.update!(
              access_token: client.access_token,
              refresh_token: client.refresh_token
            )
          rescue ::Coinbase::Wallet::APIError => e
            Rails.logger.warn "Refresh access token failed. Coinbase::Wallet::APIError: #{e.message} Identity uid: #{identity.uid}"
            nil
          end
        end
      end
    end
  end
end
