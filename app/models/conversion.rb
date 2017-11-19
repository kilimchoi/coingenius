class Conversion < ApplicationRecord
  belongs_to :receive_coin, class_name: "Coin"
  belongs_to :sending_coin, class_name: "Coin"
  belongs_to :user

  validates :amount,
            :max_amount,
            :min_amount,
            :rate,
            :return_address,
            :withdrawal_address,
            presence: true

  validates :deposit_address, presence: true, on: :update
end
