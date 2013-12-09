class AddBannerToShop < ActiveRecord::Migration
  def change
    change_table :shops do |t|
      t.string :banner
    end
  end
end
