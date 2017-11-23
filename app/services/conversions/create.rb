module Conversions
  class Create
    include Interactor::Organizer

    organize Conversions::Build

    delegate :conversion, to: :context

    def call
      super

      Conversion.transaction do
        conversion.update(attributes)

        context.fail! if conversion.new_record?

        conversion.update(
          deposit_address: shapeshift_deposit["deposit"],
          raw_data: shapeshift_deposit
        )

        Conversions::UpdateStatusWorker.perform_async(conversion_id: conversion.id)
      end
    end

    private

    def attributes
      {
        amount: context.amount,
        return_address: context.return_address,
        withdrawal_address: context.withdrawal_address,
      }
    end

    def shapeshift_deposit
       context.shapeshift_deposit ||= Container[:shapeshift_client].shift(
         api_key: ENV["SHAPESHIFT_PUBLIC_KEY"],
         pair: context.pair,
         return_address: context.return_address,
         withdrawal: context.withdrawal_address
       )
    end
  end
end
