class ConversionStateMachine
  include Statesman::Machine

  state :pending, initial: true
  state :received
  state :complete
  state :failed
  state :error

  transition from: :pending, to: %i(received complete failed error)
  transition from: :received, to: %i(complete failed error)
end
