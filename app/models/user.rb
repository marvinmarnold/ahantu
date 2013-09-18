class User < ActiveRecord::Base
	has_many :billing_informations
	has_many :credit_cards
	has_many :carts
  has_many :searches
  has_many :responsibilities
	belongs_to :profile, polymorphic: true

	delegate :guest?, :to_s, :shopper?, :shop_owner?, :salesperson?, :admin?, :email, :locale, :set_locale,
    to: :profile

  validates :profile_id,
    presence: true

  before_validation :set_guest_profile

  def search
    ((s = searches).blank?) ? new_search : s.first
  end

  def new_search
    searches.build
  end

private

  def set_guest_profile
    self.profile ||= GuestProfile.create!
  end

end
