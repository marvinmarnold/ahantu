class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.belongs_to :cart, index: true
      t.belongs_to :item, index: true
      t.string :responsible_name
      t.integer :adults
      t.string :name_at_checkout
      t.integer :quantity

      t.timestamps
    end
  end
end
