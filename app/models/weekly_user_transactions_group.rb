class WeeklyUserTransactionsGroup < ApplicationRecord
  self.primary_key = :id

  belongs_to :user
  belongs_to :coin

  scope :by_week_number, ->(direction = :desc) { order(week_number: direction) }
  scope :recent_by_coin, -> {
    select("DISTINCT ON(coin_id) *, MAX(week_number) OVER (PARTITION BY coin_id) AS week_number").reorder(:coin_id)
  }

  class << self
    def refresh
      Scenic
        .database
        .refresh_materialized_view(
          table_name,
          concurrently: false,
          cascade: false
        )
    end
  end
end
