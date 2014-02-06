class AddAcceptedToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :terms_accepted, :boolean
  end
end
