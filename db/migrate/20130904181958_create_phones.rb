class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.belongs_to :shop, index: true
      t.string :number
      t.string :name

      t.timestamps
    end
  end
end
