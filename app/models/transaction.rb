class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :coin

  enum transaction_type: %i(bought sold)

  validates :transaction_type, presence: true
  validates :amount, presence: true

  def description
    [transaction_type.titleize, coin.name].join(" ")
  end
end
