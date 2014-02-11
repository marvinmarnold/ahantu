class AddTimestampsToCart < ActiveRecord::Migration
  def change
    add_column :carts, :shopping_at, :datetime
    add_column :carts, :payment_received_at, :datetime
    add_column :carts, :finished_at, :datetime
    remove_column :carts, :submitted_at
    remove_column :carts, :payment_processed_at
  end
end
