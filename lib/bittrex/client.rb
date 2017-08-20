require "faraday"
require "base64"
require_relative "client/response"

module Bittrex
  class Client
    HOST = "https://bittrex.com/api/v1.1".freeze

    class BaseError < StandardError; end

    attr_reader :key, :secret

    def initialize(attrs = {})
      @key = attrs[:key]
      @secret = attrs[:secret]
    end

    def deposits
      get("account/getdeposithistory").map {|data| Deposit.new(data)}
    end

    def withdrawals
      get('account/getwithdrawalhistory').map {|data| Withdrawal.new(data)}
    end

    def order_history
      get('account/getorderhistory').map {|data| Order.new(data)}
    end

    private

    def get(path, params = {}, _headers = {})
      nonce = Time.now.to_i
      response = Response.new(faraday_get(nonce, params, path))

      handle_error(response) || response.result
    end

    def faraday_get(nonce, params, path)
      connection.get do |req|
        url = "#{HOST}/#{path}"
        req.params.merge!(params)
        req.url(url)

        if key
          req.params[:apikey] = key
          req.params[:nonce] = nonce
          req.headers[:apisign] = signature(url, nonce)
        end
      end
    end

    def signature(url, nonce)
      OpenSSL::HMAC.hexdigest("sha512", secret, "#{url}?apikey=#{key}&nonce=#{nonce}")
    end

    def connection
      @connection ||= Faraday.new(:url => HOST) do |faraday|
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter
      end
    end

    def handle_error(response)
      return if response.success?

      raise BaseError, response.message
    end
  end
end
