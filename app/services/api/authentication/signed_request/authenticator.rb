module Api
  module Authentication
    module SignedRequest
      # Authenticator is responsible for an API authentication based on `Authorization`
      # HTTP header. It's supposed to be used in context of controller and accept `request`
      # as the only parameter.
      #
      # Authorization header is expected to have the following format:
      #   "CGSR <key>:<signature>"
      #
      # Where:
      # * `CGSR` stays for "CoinGenius Signed Request".
      # * `key` is a key issued to a client and is the same as in {UserApiCredentials} model.
      # * `signature` calculated as concatenated query parameters and raw body
      #    signed by HMAC512 with `secret` (issued to a client and stored in {UserApiCredentials}).
      #
      # @example success
      #   result = Authenticator.call(request)
      #   result.success? => true
      #   result.account => User<id=123 ...>
      #
      # @example failure
      #   result = Authenticator.call(request)
      #   result.failure? => true
      #   result.reason   => :nonce_too_small
      #   result.message  => "Nonce must be higher than previous value 12345. Given 12343."
      #
      class Authenticator
        include Interactor

        # CoinGenius authorization scheme
        AUTHORIZATION_TYPE = "CGSR".freeze

        # Regex to validate simple Authorization header format
        AUTHORIZATION_HEADER_REGEXP = /\A#{AUTHORIZATION_TYPE} \w+:\w+\z/

        # Max size of PostgreSQL's BIGINT type
        MAX_NONCE = 9_223_372_036_854_775_807

        # Range of the valid values for nonce
        NONCE_RANGE = 0..MAX_NONCE

        attr_reader :key, :signature

        delegate :request, to: :context

        before do
          assign_key_and_signature
          fail_with(:nonce_missing) if raw_nonce.blank?
          fail_with(:nonce_out_of_range) unless nonce.in?(NONCE_RANGE)
          fail_with(:key_not_found) if user_api_credential.blank?
        end

        def call
          validate_signature
          validate_nonce

          # At this point authentication is successful
          user_api_credential.update!(nonce: nonce)
          context.user = user_api_credential.user
        end

        private

        def assign_key_and_signature
          authorization = request.env["HTTP_AUTHORIZATION"].to_s.strip
          fail_with(:authorization_header_missing) if authorization.blank?
          fail_with(:authorization_header_format_invalid) unless authorization.match?(AUTHORIZATION_HEADER_REGEXP)

          credentials = authorization.split(" ", 2).last
          @key, @signature = credentials.split(":", 2)
        end

        def raw_nonce
          @raw_nonce ||= request.query_parameters["nonce"]
        end

        def nonce
          @nonce ||= raw_nonce.to_i
        end

        def user_api_credential
          @user_api_credential ||= UserApiCredential.find_by(key: key)
        end

        def validate_signature
          fail_with(:signature_invalid) if signature != build_valid_signature
        end

        def validate_nonce
          fail_with(:nonce_too_small) unless nonce > user_api_credential.nonce
        end

        def build_valid_signature
          raw_post = request.raw_post
          data = [query_string, raw_post].join("\n")
          OpenSSL::HMAC.hexdigest("SHA512", user_api_credential.secret, data)
        end

        def query_string
          @query_string ||= request.query_parameters.to_query
        end

        def fail_with(reason)
          context.fail!(reason: reason, message: build_message(reason))
        end

        def build_message(reason) # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity
          case reason
          when :authorization_header_missing
            "Authorization header must be provided."
          when :authorization_header_format_invalid
            "Authorization header format is invalid. Valid format is '#{AUTHORIZATION_TYPE} <key>:<signature>'."
          when :nonce_missing
            "Parameter 'nonce' is missing."
          when :nonce_out_of_range
            "Nonce must be an integer from 0 to #{MAX_NONCE}. Given #{raw_nonce}."
          when :key_not_found, :signature_invalid
            "Key or HMAC signature is invalid"
          when :nonce_too_small
            "Nonce must be higher than previous value #{user_api_credential.nonce}. Given #{nonce}."
          end
        end
      end
    end
  end
end
