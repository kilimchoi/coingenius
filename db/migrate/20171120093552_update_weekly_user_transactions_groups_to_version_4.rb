class UpdateWeeklyUserTransactionsGroupsToVersion4 < ActiveRecord::Migration[5.0]
  def change
    update_view :weekly_user_transactions_groups, version: 4, revert_to_version: 3, materialized: true
  end
end
