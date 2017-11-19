module Conversions
  class Create
    include Interactor

    delegate :params, :user, to: :context

    before do
      context.params ||= {}
      context.conversion = nil
    end

    def call
      Conversion.transaction do
        conversion.update(attributes)

        if conversion.persisted?
          Rails.logger.debug "[Conversions::Create] Created ShapeShift deposit: #{shapeshift_deposit}"

          conversion.update(
            deposit_address: shapeshift_deposit["deposit"],
            raw_data: shapeshift_deposit
          )
        end
      end
    end

    def conversion
      context.conversion ||= ConversionFactory.new(
        receive_coin_id: params[:receive_coin_id],
        sending_coin_id: params[:sending_coin_id],
        user: user
      ).build
    end

    private

    def attributes
      params.merge(user: user)
    end

    def shapeshift_deposit
      context.shapeshift_deposit ||= Container[:shapeshift_client].shift(
        withdrawal: params[:withdrawal_address],
        return_address: params[:return_address],
        pair: pair,
        api_key: ENV["SHAPESHIFT_PUBLIC_KEY"]
      )
    end

    def pair
      [conversion.sending_coin, conversion.receive_coin].map(&:symbol).map(&:downcase).join("_")
    end
  end
end
