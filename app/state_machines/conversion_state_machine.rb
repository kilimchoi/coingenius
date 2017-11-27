class ConversionStateMachine
  include Statesman::Machine

  COMPLETE_STATE = :complete
  FAILED_STATE = :failed
  ERROR_STATE = :error
  FINAL_STATES = [COMPLETE_STATE, ERROR_STATE, FAILED_STATE].freeze

  state :pending, initial: true
  state :received
  state COMPLETE_STATE
  state FAILED_STATE
  state ERROR_STATE

  transition from: :pending, to: FINAL_STATES + [:received]
  transition from: :received, to: FINAL_STATES
end
