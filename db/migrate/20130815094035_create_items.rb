class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :quantity
      t.belongs_to :shop, index: true
      t.integer :max_adults
      t.boolean :published, default: false
      t.float :default_price

      t.timestamps
    end
  end
end
