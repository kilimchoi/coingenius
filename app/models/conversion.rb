class Conversion < ApplicationRecord
  include StateMachine

  belongs_to :receive_coin, class_name: "Coin"
  belongs_to :sending_coin, class_name: "Coin"
  belongs_to :user

  # Maps to ShapeShift transaction status
  enum status: %i[no_deposits received complete failed]

  validates :amount,
    :max_amount,
    :min_amount,
    :rate,
    presence: true

  validates :deposit_address,
    :return_address,
    :withdrawal_address,
    presence: true,
    on: :update
end
