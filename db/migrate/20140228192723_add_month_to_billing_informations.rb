class AddMonthToBillingInformations < ActiveRecord::Migration
  def change
    add_column :billing_informations, :month, :integer
  end
end
