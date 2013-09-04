class Cart < ActiveRecord::Base
  belongs_to :user
  belongs_to :billing_information
  has_many :bookings

  accepts_nested_attributes_for :bookings

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

  def fill_bookings(search)
    self.bookings.each do |b|
      search.dates.each do |d|
        b.line_items.create!(booking_at: d, unit_price_at_checkout: b.item.price(d))
      end
    end
  end

  ##############################################################################################################
  ### state machine
  ##############################################################################################################

  state_machine :state, :initial => :shopping do

    state :submitted do
      validates_presence_of :billing_information_id, :email, :phone,
        presence: true
    end

    state :payment_processed do
      validates_presence_of :payment_amount, :payment_at,
        presence: true
      validate :full_payment
    end

    event :submit do
      transition :shopping => :submitted
    end

    event :pay do
      transition :submitted => :payment_processed
    end

  end

  ##############################################################################################################
  ###
  ##############################################################################################################

private

  def full_payment
    self.payment_amount == total ? true : errors[:payment_amount] << "not full payment"
  end
end
