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

  def order_number
    id.to_s.rjust(6, '0')
  end

  def shop
    bookings.first.shop
  end

  def confirmed?
    bookings.all? { |b| b.confirmed }
  end

  def to_s
    "#{order_number} - #{shop}"
  end

  def shop_cut
    bookings.map { |b| b.shop_cut }.reduce(:+)
  end

  def receive_confirmation(sms)
    if sms.sanitized.match("^#{order_number}")
      confirm
    elsif sms.sanitized.match("^x#{order_number}")
      cancle
    else
      false
    end
  end

  def self.find_cart(order_number)
    Cart.all.reject { |c| c.confirmed? }.find { |c| c.order_number == order_number }
  end

  ##############################################################################################################
  ### state machine
  ##############################################################################################################

  state_machine :state, :initial => :shopping do

    state :authorizing_payment do
      validates :billing_information_id, :email, :phone, :payment_amount,
        presence: true
    end

    state :payment_processed do
      validates :payment_at,
        presence: true
    end

    before_transition :shopping => :authorizing_payment, :do => :set_payment_amount
    after_transition :on => :authorize_payment, :do => :submit_payment_authorization
    event :authorize_payment do
      transition :shopping => :authorizing_payment
    end

    after_transition :on => :submit, :do => :send_confirmation
    event :submit do
      transition :authorizing_payment => :submitted
    end

    event :pay do
      transition :submitted => :processing_payment
    end

    event :confirm_payment do
      transition :processing_payment => :payment_received
    end

    after_transition :on => :cancle, :do => :send_cancelation
    even :cancle do
      transition all => :canceled
    end

  end

  ##############################################################################################################
  ###
  ##############################################################################################################

private

  def confirm
    bookings.each { |b| b.confirm }
  end

  def unconfirm
    cancle
  end

  def responsibles
    shop.responsibles
  end

  def submit_payment_authorization
    #TODO - paypal
    self.submit
  end

  def send_cancelation
    #send phone notice
    send_email_cancelation
  end

  def send_email_cancelation
    ShopperMailer.cancelation(self).deliver
  end

  def send_confirmation
    #send_phone_confirmation
    send_email_confirmation
  end

  def send_phone_confirmation
    shop.phones.each do |p|
      Sm.send(p, confirmation_message, self)
    end
  end

  def send_email_confirmation
    #send email to all responsibles
    responsibles.each do |r|
      SalespersonMailer.booking_confirmation(self).deliver
    end
    #send email to shop
  end

  def set_payment_amount
    self.payment_amount = total
  end

  def confirmation_message
    "#{order_number} - #{bookings_summary}"
  end

  def bookings_summary
    "".tap do |s|
      bookings.each do |b|
        s += b.sms_summary
      end
    end
  end
end
