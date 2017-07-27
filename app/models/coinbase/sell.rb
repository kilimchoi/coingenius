module Coinbase
  class Sell < ActiveRecord::Base
    belongs_to :transaction

    validates :uuid, presence: true
  end
end
