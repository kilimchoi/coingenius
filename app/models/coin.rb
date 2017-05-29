class Coin < ActiveRecord::Base
  has_and_belongs_to_many :exchanges
end
