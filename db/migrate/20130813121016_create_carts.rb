class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.datetime :submitted_at
      t.datetime :processing_payment_at
      t.datetime :payment_processed_at
      t.datetime :authorizing_payment_at
      t.datetime :cancelled_at
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
