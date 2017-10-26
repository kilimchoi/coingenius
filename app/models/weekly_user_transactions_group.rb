class WeeklyUserTransactionsGroup < ApplicationRecord
  self.primary_key = :id

  RECENT_BY_COIN_SELECT = %{
    DISTINCT ON(coin_id) *,
    MAX(week_starts_at)
    OVER (PARTITION BY coin_id ORDER BY week_starts_at DESC) AS week_starts_at
  }.squish.freeze

  belongs_to :user
  belongs_to :coin

  scope :recent_by_coin, -> { select(RECENT_BY_COIN_SELECT).reorder(:coin_id) }

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
