class Conversion < ApplicationRecord
  belongs_to :receive_coin, class_name: "Coin"
  belongs_to :sending_coin, class_name: "Coin"

  validates :deposit_address,
            :return_address,
            :withdrawal_address,
            presence: true
end
