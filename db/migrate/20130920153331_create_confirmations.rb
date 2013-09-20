class CreateConfirmations < ActiveRecord::Migration
  def change
    create_table :confirmations do |t|
      t.text :message
      t.string :type
      t.belongs_to :booking, index: true
      t.datetime :sent_at

      t.belongs_to :sender, index: true, polymorphic: true
      t.belongs_to :recipient, index: true, polymorphic: true

      t.timestamps
    end
  end
end
