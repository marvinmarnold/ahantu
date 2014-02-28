class CleanUpBillingInformation < ActiveRecord::Migration
  def change
    add_column :billing_informations, :year, :integer
    add_column :billing_informations, :full_name, :string
    remove_column :billing_informations, :expiration
  end
end


