class CreateGuestProfiles < ActiveRecord::Migration
  def change
    create_table :guest_profiles do |t|
      t.belongs_to :language, index: true

      t.timestamps
    end
  end
end
