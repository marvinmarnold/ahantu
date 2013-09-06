class CreateResponsibilities < ActiveRecord::Migration
  def change
    create_table :responsibilities do |t|
      t.belongs_to :user, index: true
      t.belongs_to :shop, index: true

      t.timestamps
    end
  end
end
