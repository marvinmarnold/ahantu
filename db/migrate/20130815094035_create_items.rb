class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :quantity
      t.belongs_to :shop, index: true
      t.integer :max_adults
      t.boolean :published
      t.float :default_price
      t.string :short

      t.timestamps
    end
  end
end
