class AddSearchToCart < ActiveRecord::Migration
  def change
    change_table :carts do |t|
      t.belongs_to :search, index: true
    end
  end
end
