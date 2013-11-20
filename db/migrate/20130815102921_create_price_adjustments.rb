class CreatePriceAdjustments < ActiveRecord::Migration
  def change
    create_table :price_adjustments do |t|
      t.belongs_to :item, index: true
      t.float :price
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
