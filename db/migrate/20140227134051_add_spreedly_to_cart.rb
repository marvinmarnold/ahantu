class AddSpreedlyToCart < ActiveRecord::Migration
  def change
    add_column :carts, :auth_transaction_token, :string
    add_column :carts, :capture_transaction_token, :string
  end
end
