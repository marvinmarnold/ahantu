class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.belongs_to :user, index: true
      t.datetime :checkout_at
      t.datetime :payment_at
      t.float :payment_amount
      t.belongs_to :billing_information, index: true
      t.string :state
      t.string :email
      t.string :phone
      t.string :order_confirmation

      t.timestamps
    end
  end
end
