class CreateWeeklyUserTransactionsGroups < ActiveRecord::Migration[5.0]
  def change
    create_view :weekly_user_transactions_groups, materialized: true
  end
end
