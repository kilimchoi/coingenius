module Conversions
  class UpdateStatus
    include Interactor

    delegate :conversion, :transaction_status, to: :context

    before do
      context.fail! if conversion.in_state?(*ConversionStateMachine::FINAL_STATES)
    end

    def call
      context.transaction_status = fetch_transaction_status

      Rails.logger.debug "[Conversions::UpdateStatus] Got ShapeShift transaction status: #{transaction_status}"

      conversion.update(raw_data: transaction_status) if transit
    end

    private

    def transit
      conversion.transition_to(transaction_status["status"])
    end

    def fetch_transaction_status
      Container[:shapeshift_client]
        .transaction_status(deposit_address: conversion.deposit_address)
    end
  end
end
