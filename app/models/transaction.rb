class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :coin

  enum transaction_type: [ :bought, :sold ]

  validates :transaction_type, presence: true
  validates :amount, presence: true

  def description
    desc = ""
    desc += transaction_type.titleize
    desc += " "
    desc += " #{coin.name} (#{coin.symbol})"  
  end
  
end
