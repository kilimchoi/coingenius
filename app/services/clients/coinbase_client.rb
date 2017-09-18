module Clients 
  class CoinbaseClient
    include Interactor
    delegate :user, to: :context

    def call
      @client ||= ::Coinbase::Wallet::OAuthClient.new(access_token: coinbase_identity.access_token) unless coinbase_identity.nil?
    end

    private 

    def coinbase_identity
      @coinbase_identity ||= user.identities.find_by(provider: :coinbase)
    end
  end
end
