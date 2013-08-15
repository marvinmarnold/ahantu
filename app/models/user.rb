class User < ActiveRecord::Base
	has_many :billing_informations
	has_many :credit_cards
	has_many :carts
	belongs_to :profile, polymorphic: true

	delegate :guest?, :to_s, :shopper?, :shop_owner?, :salesperson?, :admin?, :email, :locale,
    to: :profile

  validates :profile_id,
    presence: true

  before_validation :set_guest_profile

private

  def set_guest_profile
    self.profile ||= GuestProfile.create!
  end

end
