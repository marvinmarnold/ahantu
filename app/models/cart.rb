class Cart < ActiveRecord::Base
  belongs_to :user
  belongs_to :shop
  belongs_to :billing_information
  has_many :bookings

  accepts_nested_attributes_for :bookings

  before_save :set_checkout_details

  validates :user_id,
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
        c.bookings.build(adults: rs.adults)
      end
      
    end
  end

  ##############################################################################################################
  ### state machine
  ##############################################################################################################

  state_machine :state, :initial => :shopping do

    state :checking_out do
      validates_presence_of :billing_information_id, :payment_amount, :payment_at,
        presence: true
      validate :full_payment

    end

  end

  ##############################################################################################################
  ###
  ##############################################################################################################

private

  def set_checkout_details
    total_at_checkout = total
    payment_amount = total_at_checkout
    payment_at = Time.now
  end

  def full_payment
    self.payment_amount == total ? true : errors[:payment_amount] << "not full payment"
  end
end
