class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.belongs_to :booking, index: true
      t.float :unit_price_at_checkout
      t.date :booking_at

      t.timestamps
    end
  end
end
