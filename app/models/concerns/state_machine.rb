module StateMachine
  extend ActiveSupport::Concern

  included do
    has_many :transitions, class_name: transition_class.to_s, autosave: false

    # Optionally delegate some methods
    delegate :can_transition_to?,
      :current_state,
      :in_state?,
      :transition_to,
      :transition_to!,
      to: :state_machine
  end

  # Initialize the state machine
  def state_machine
    @state_machine ||= ConversionStateMachine.new(
      self,
      transition_class: self.class.transition_class,
      association_name: :transitions
    )
  end

  module ClassMethods
    def transition_class
      "#{name}Transition".constantize
    end
  end
end
