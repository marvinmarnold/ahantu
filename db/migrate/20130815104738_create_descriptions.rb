class CreateDescriptions < ActiveRecord::Migration
  def change
    create_table :descriptions do |t|
      t.belongs_to :language, index: true
      t.string :name
      t.text :description
      t.belongs_to :describable, index: true, polymorphic: true

      t.timestamps
    end
  end
end
