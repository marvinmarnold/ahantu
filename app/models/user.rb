class User < ActiveRecord::Base
	has_many :billing_informations
	has_many :credit_cards
	has_many :carts
  has_many :searches
  has_many :responsibilities
  has_many :responsible_shops, through: :responsibilities, source: :shop
  has_many :responsible_carts, through: :responsible_shops, source: :carts
  has_many :owned_shops, class_name: "Shop"
  has_many :client_carts, through: :owned_shops, source: :carts
	belongs_to :profile, polymorphic: true

	delegate :guest?, :to_s, :shopper?, :shop_owner?, :salesperson?,
    :admin?, :email, :locale, :set_locale,
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

  def shops
    case profile.role
    when "shopper"
      Shop.none
    when "guest"
      Shop.none
    when "shop_owner"
      owned_shops
    when "salesperson"
      responsible_shops
    when "admin"
      Shop.all
    end
  end

  def browsable_carts
    case profile.role
    when "shopper"
      carts.submitted
    when "guest"
      carts.submitted
    when "shop_owner"
      client_carts
    when "salesperson"
      responsible_carts
    when "admin"
      Cart.all
    end
  end

private

  def set_guest_profile
    self.profile ||= GuestProfile.create!
  end

end
