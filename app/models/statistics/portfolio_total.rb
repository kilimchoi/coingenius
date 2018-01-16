module Statistics
  class PortfolioTotal < ApplicationRecord
    belongs_to :coin
    belongs_to :user

    def readonly?
      true
    end
  end
end
