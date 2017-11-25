module Conversions
  class UpdateStatusWorker
    include Sidekiq::Worker

    # @param [Integer] conversion_id
    def perform(conversion_id)
      @conversion_id = conversion_id

      Rails.logger.debug state_message

      self.class.perform_in(10, conversion_id) unless conversion_in_final_state?
    end

    private

    def conversion_in_final_state?
      update_status_result.conversion.in_state?(*ConversionStateMachine::FINAL_STATES)
    end

    def update_status_result
      @update_status_result ||= Conversions::UpdateStatus.call(conversion: Conversion.find(@conversion_id))
    end

    def state_message
      status = conversion_in_final_state? ? "Finishing" : "Rescheduling"

      "[#{self.class.name}]: #{status}"
    end
  end
end
