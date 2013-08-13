class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.belongs_to :user, index: true
      t.belongs_to :shop, index: true
      t.float :total_at_checkout
      t.datetime :payment_at
      t.float :payment_amount
      t.belongs_to :billing_information, index: true

      t.timestamps
    end
  end
end
