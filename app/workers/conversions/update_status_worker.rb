module Conversions
  class UpdateStatusWorker
    include Sidekiq::Worker

    # @param [Integer] conversion_id
    def perform(conversion_id)
      conversion = Conversion.find(conversion_id)

      result = Conversions::UpdateStatus.call(conversion: conversion)

      unless result.conversion.in_state?(*ConversionStateMachine::FINAL_STATES)
        self.class.perform_in(30, conversion_id: conversion_id)
      end
    end
  end
end
