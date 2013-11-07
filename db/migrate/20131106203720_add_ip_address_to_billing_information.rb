class AddIpAddressToBillingInformation < ActiveRecord::Migration
  def change
    change_table :billing_informations do |t|
      t.string :ip_address
    end
  end
end
