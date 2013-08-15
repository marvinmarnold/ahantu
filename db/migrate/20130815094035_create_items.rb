class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :quantity
      t.belongs_to :shop, index: true
      t.integer :max_adults
      t.boolean :published
      t.float :default_price

      t.timestamps
    end
  end
end
