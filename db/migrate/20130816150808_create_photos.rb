class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :photo
      t.belongs_to :photoable, index: true, polymorphic: true

      t.timestamps
    end
  end
end
