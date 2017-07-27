module Coinbase
  class Buy < ActiveRecord::Base
    belongs_to :transaction

    validates :uuid, presence: true
  end
end
