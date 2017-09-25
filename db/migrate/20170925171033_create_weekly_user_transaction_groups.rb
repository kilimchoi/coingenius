class CreateWeeklyUserTransactionGroups < ActiveRecord::Migration[5.0]
  def change
    create_view :weekly_user_transaction_groups, materialized: true
  end
end
