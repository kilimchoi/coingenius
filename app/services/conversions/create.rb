module Conversions
  class Create
    include Interactor::Organizer

    organize Conversions::Build

    delegate :conversion, to: :context

    def call
      super

      Conversion.transaction do
        conversion.update(amount: context.amount)

        context.fail! if conversion.new_record?

        conversion.update(
          deposit_address: shapeshift_deposit["deposit"],
          raw_data: shapeshift_deposit,
          return_address: context.return_address,
          withdrawal_address: context.withdrawal_address
        )

        Conversions::UpdateStatusWorker.perform_async(conversion.id)
      end
    end

    private

    def shapeshift_deposit
      context.shapeshift_deposit ||= create_shapeshift_deposit
    end

    def create_shapeshift_deposit
      Container[:shapeshift_client].shift(
        api_key: ENV["SHAPESHIFT_PUBLIC_KEY"],
        pair: context.pair,
        return_address: context.return_address,
        withdrawal: context.withdrawal_address
      )
    rescue RestClient::InternalServerError
      {}
    end
  end
end
