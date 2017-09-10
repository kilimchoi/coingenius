class AddClosedAtAndExecutedAtToBittrexOrder < ActiveRecord::Migration
  def change
    add_column :bittrex_orders, :closed_at, :datetime
    add_column :bittrex_orders, :executed_at, :datetime

    reversible do |dir|
      dir.up do
        BittrexOrder.find_each do |order|
          order.update_columns(
            closed_at: order.raw_data["Closed"],
            executed_at: order.raw_data["TimeStamp"]
          )
        end
      end
    end

    change_column_null :bittrex_orders, :executed_at, false
  end
end
