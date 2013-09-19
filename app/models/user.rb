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
    ((s = relevant_searches).blank?) ? new_search : s.first
  end

  def relevant_searches
    searches.find_all { |s| s.active? }
  end

  def new_search
    searches.build
  end

  def move_to_profile(new_profile)
    self.profile = new_profile
    self.save!
  end

  def last_cart
    carts.submitted.order("created_at DESC").first
  end

  def last_checkout_at
    last_cart.present? ? last_cart.created_at : Time.at(0)
  end

private

  def set_guest_profile
    self.profile ||= GuestProfile.create!
  end

end
