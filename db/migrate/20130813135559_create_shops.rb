class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.belongs_to :user, index: true
      t.belongs_to :city, index: true
      t.boolean :published, default: false
      t.string :logo
      t.string :address1
      t.string :address2
      t.text :directions
      t.string :website1
      t.string :website2
      t.string :website3
      t.string :website4
      t.string :website5
      t.float :commission_pct

      t.timestamps
    end
  end
end
