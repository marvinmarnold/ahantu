class CreateSms < ActiveRecord::Migration
  def change
    create_table :sms do |t|
      t.belongs_to :cart, index: true
      t.text :message
      t.belongs_to :phone, index: true
      t.boolean :incoming
      t.datetime :sent_at

      t.timestamps
    end
  end
end
