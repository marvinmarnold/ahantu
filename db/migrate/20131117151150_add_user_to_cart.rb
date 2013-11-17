class AddUserToCart < ActiveRecord::Migration
  def change
    change_table :carts do |t|
      t.belongs_to :user, index: true
    end
  end
end
