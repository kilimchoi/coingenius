module Conversions
  class UpdateStatus
    include Interactor

    delegate :conversion, :transaction_status, to: :context

    def call
      context.transaction_status = fetch_transaction_status

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
