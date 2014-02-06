class AddStateToBillingInformations < ActiveRecord::Migration
  def change
    add_column :billing_informations, :state, :string
  end
end
