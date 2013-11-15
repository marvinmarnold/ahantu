class CreateContactForms < ActiveRecord::Migration
  def change
    create_table :contact_forms do |t|
      t.string :subject
      t.string :from
      t.string :to
      t.string :state
      t.text :body

      t.timestamps
    end
  end
end
