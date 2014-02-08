class User < ActiveRecord::Base
	has_many :billing_informations
	has_many :credit_cards
  has_many :searches, inverse_of: :user
  has_many :carts
  has_many :responsibilities
  has_many :responsible_shops, through: :responsibilities, source: :shop
  has_many :responsible_carts, through: :responsible_shops, source: :carts
  has_many :owned_shops, class_name: "Shop", inverse_of: :user
  has_many :client_carts, through: :owned_shops, source: :carts
  has_many :contact_forms
	belongs_to :profile, polymorphic: true

	delegate :guest?, :to_s, :shopper?, :shop_owner?, :salesperson?, :admin?, :shop_requests,
    :admin?, :email, :locale, :set_locale,
      to: :profile

  validates :profile_id,
    presence: true

  before_validation :set_guest_profile

  def search
    ((s = relevant_searches).blank?) ? new_search : s.order("created_at DESC").first
  end

  def relevant_searches
    Search.active searches
  end

  def new_search
    searches.build.add_suggested_room_searches
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
    if shopper?
      Shop.none
    elsif guest?
      Shop.none
    elsif shop_owner?
      owned_shops
    elsif salesperson?
      responsible_shops
    elsif admin?
      Shop.all
    end
  end

  def browsable_carts
    if shopper?
      carts.submitted
    elsif guest?
      carts.submitted
    elsif shop_owner?
      client_carts
    elsif salesperson?
      responsible_carts
    elsif admin?
      Cart.all
    end
  end

  def suggested_checkin_at
    Date.today
  end

  def suggested_checkout_at
    suggested_checkin_at + suggested_stay_length
  end

  def suggested_stay_length
    1.week
  end

  def suggested_num_room_searches
    1
  end

  def suggested_room_search_adults
    2
  end

private

  def set_guest_profile
    self.profile ||= GuestProfile.create!
  end

end
