module Users
  module Coinbase
    # This module provides a simple way to init Coinbase client
    # based on user's coinbase identity.
    #
    # Requires object to implement `#user`
    module Client
      def client
        @client ||= ::Coinbase::Wallet::OAuthClient.new(access_token: coinbase_identity.access_token) if coinbase_identity
      end

      private

      def coinbase_identity
        @coinbase_identity ||= user.identities.find_by(provider: :coinbase)
      end
    end
  end
end
