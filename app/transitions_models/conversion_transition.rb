class ConversionTransition < ApplicationRecord
  include Statesman::Adapters

  belongs_to :conversion, inverse_of: :transitions

  after_destroy :update_most_recent, if: :most_recent?

  private

  def update_most_recent
    last_transition = conversion.conversion_transitions.order(:sort_key).last
    return if last_transition.blank?
    last_transition.update_column(:most_recent, true)
  end
end
