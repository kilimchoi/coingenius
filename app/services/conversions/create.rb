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
          deposit_address: shapeshift_deposit["success"]["deposit"],
          rate: shapeshift_deposit["success"]["quotedRate"],
          raw_data: shapeshift_deposit["success"],
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

    def shapeshift_params
      {
        amount: context.amount,
        api_key: ENV["SHAPESHIFT_PUBLIC_KEY"],
        deposit_amount: true,
        pair: context.pair,
        payment_id: context.payment_id,
        return_address: context.return_address,
        withdrawal: context.withdrawal_address
      }.compact
    end

    def create_shapeshift_deposit
      Rails.logger.info "[#{self.class.name}]: Placing order for the new ShapeShift deposit with params: #{shapeshift_params.inspect}"

      Container[:shapeshift_client].fixed_amount_transaction(shapeshift_params)
    rescue RestClient::InternalServerError
      Rails.logger.error "[#{self.class.name}]: ShapeShift deposit creation failed"
      {}
    end
  end
end
