class Cart < ActiveRecord::Base
  belongs_to :user
  belongs_to :shop
  belongs_to :billing_information
  has_many :bookings

  accepts_nested_attributes_for :bookings

  before_save :set_checkout_details

  validates :user_id, #:shop_id, :billing_information_id, :total_at_checkout, :payment_amount, :payment_at,
    presence: true



  def total
  	subtotal + taxes
  end

  def subtotal
  	0
  end

  def taxes 
  	5
  end

  def self.new_from_search(search)
    Cart.new.tap do |c|
      search.room_searches.each do |rs|
        c.bookings.build
      end
    end

  end

private

  def set_checkout_details
    total_at_checkout = total
    payment_amount = total_at_checkout
    payment_at = Time.now
  end
end
