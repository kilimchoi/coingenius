class UpdateWeeklyUserTransactionsGroupsToVersion3 < ActiveRecord::Migration[5.0]
  def change
    update_view :weekly_user_transactions_groups, version: 3, revert_to_version: 2, materialized: true
  end
end
