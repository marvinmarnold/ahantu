class AddShopToShopRequest < ActiveRecord::Migration
  def change
    change_table :shop_requests do |t|
      t.belongs_to :shop, index: true
    end
  end
end
