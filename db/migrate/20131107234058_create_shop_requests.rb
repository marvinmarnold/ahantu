class CreateShopRequests < ActiveRecord::Migration
  def change
    create_table :shop_requests do |t|
      t.belongs_to :user, index: true
      t.string :state
      t.text :request

      t.timestamps
    end
  end
end
