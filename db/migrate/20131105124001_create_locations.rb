class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :ancestry, index: true
      t.string :name

      t.timestamps
    end
  end
end
