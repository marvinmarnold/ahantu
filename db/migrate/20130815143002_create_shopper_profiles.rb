class CreateShopperProfiles < ActiveRecord::Migration
  def change
    create_table :shopper_profiles do |t|
      t.belongs_to :language, index: true

      t.timestamps
    end
  end
end
