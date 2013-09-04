class CreateRoomSearches < ActiveRecord::Migration
  def change
    create_table :room_searches do |t|
      t.belongs_to :search, index: true
      t.integer :adults

      t.timestamps
    end
  end
end
