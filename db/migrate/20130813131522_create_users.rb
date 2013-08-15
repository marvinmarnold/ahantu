class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.belongs_to :profile, polymorphic: true, index: true

      t.timestamps
    end
  end
end
