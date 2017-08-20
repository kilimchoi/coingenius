require "json"
require "ostruct"

module Bittrex
  class Client
    class Response
      delegate :result, :message, :success, to: :parsed_response

      # @param [Faraday::Response] faraday_response
      def initialize(faraday_response)
        @faraday_response = faraday_response
      end

      def success?
        parsed_response.success === true
      end

      def failure?
        !success?
      end

      def raw
        parsed_response
      end

      private

      def parsed_response
        @parsed_response ||= OpenStruct.new(JSON.parse(@faraday_response.body))
      end
    end
  end
end
