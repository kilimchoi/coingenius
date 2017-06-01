class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :coin

  enum transaction_type: [ :buy, :sell ]

  validates :transaction_type, presence: true
  validates :amount, presence: true
  
end
