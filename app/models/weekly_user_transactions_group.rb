##
# This class represents materialized view +weekly_user_transactions_groups+
#
# Each record contains aggregated information about user's transactions for the week where he has any transactions
#
# Columns overview:
# * +id+ _uuid_ Unique identifier
# * +week_starts_at+ _datetime_ Start of the week
# * +week_ends_at+ _datetime_ End of the week
# * +week_number+ _string_ Formatted week number with year, example: 2017-03
# * +user_id+ _integer_ users table foreign key
# * +coin_id+ _integer_ coins table foreign key
# * +weekly_transactions_count+ _integer_ quantity of transactions for the week
# * +weekly_total+ _decimal_ sum of amount of the transactions for the week
# * +total_amount+ _decimal_ sum of amount of all transactions distinguished by coin_id and user_id

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
