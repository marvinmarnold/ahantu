class CreateShopRequests < ActiveRecord::Migration
  def change
    create_table :shop_requests do |t|
      t.belongs_to :shop_owner_profile, index: true
      t.belongs_to :salesperson_profile, index: true
      t.belongs_to :location, index: true
      t.string :state
      t.text :request
      t.string :shop_name

      t.timestamps
    end
  end
end
