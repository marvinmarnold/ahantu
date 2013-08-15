class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :keyword
      t.date :checkin_at
      t.date :checkout_at
      t.integer :adults
      t.belongs_to :user, index: true
      t.belongs_to :item, index: true
      t.belongs_to :shop, index: true

      t.timestamps
    end
  end
end
