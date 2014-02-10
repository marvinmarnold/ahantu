class AddItemToSearches < ActiveRecord::Migration
  def change
    add_reference :searches, :item, index: true
  end
end
