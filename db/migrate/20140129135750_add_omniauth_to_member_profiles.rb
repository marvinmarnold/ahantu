class AddOmniauthToMemberProfiles < ActiveRecord::Migration
  def change
    add_column :member_profiles, :provider, :string
    add_column :member_profiles, :uid, :string
  end
end
