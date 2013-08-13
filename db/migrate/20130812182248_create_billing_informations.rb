class CreateBillingInformations < ActiveRecord::Migration
  def change
    create_table :billing_informations do |t|
      t.string :first_name
      t.string :last_name
      t.date :expiration
      t.string :type
      t.string :brand
      t.string :number_last_four

      t.timestamps
    end
  end
end
