class UpdateWeeklyUserTransactionsGroupsToVersion2 < ActiveRecord::Migration[5.0]
  def change
    update_view :weekly_user_transactions_groups, version: 2, revert_to_version: 1, materialized: true
  end
end
