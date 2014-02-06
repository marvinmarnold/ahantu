class AddSavedGatewayIdToBillingInformations < ActiveRecord::Migration
  def change
    add_column :billing_informations, :saved_gateway_id, :string
  end
end
