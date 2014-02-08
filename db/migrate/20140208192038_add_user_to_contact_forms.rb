class AddUserToContactForms < ActiveRecord::Migration
  def change
    add_reference :contact_forms, :user, index: true
  end
end
