module Users
  module Coinbase
    class RefreshAccessTokens
      include Sidekiq::Worker

      def perform
        Identity.where(provider: :coinbase).find_each do |identity|
          # Init client with an existing refresh token
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
        end
      rescue Coinbase::Wallet::APIError
        nil
      end
    end
  end
end
