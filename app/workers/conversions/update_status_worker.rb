module Conversions
  class UpdateStatusWorker
    include Sidekiq::Worker

    # @param [Integer] conversion_id
    def perform(conversion_id)
      conversion = Conversion.find(conversion_id)

      Conversions::UpdateStatus.call(conversion: conversion)
    end
  end
end
