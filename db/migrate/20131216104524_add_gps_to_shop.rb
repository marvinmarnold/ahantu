class AddGpsToShop < ActiveRecord::Migration
  def change
    change_table :shops do |t|
      t.float :latitude
      t.float :longitude
    end
  end
end
