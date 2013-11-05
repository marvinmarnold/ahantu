class Cart < ActiveRecord::Base
  belongs_to :user
  belongs_to :billing_information
  has_many :bookings, dependent: :destroy

  accepts_nested_attributes_for :bookings

  validates :user_id,
    presence: true

  scope :submitted, lambda { where.not(state: :shopping) }
  scope :unsubmitted, lambda { where(state: :shopping) }

  def total
  	subtotal + taxes
  end

  def subtotal
  	bookings.map { |b| b.total }.reduce(:+)
  end

  def taxes
  	0
  end

  def self.new_from_search(search, item = nil)
    Cart.new.tap do |c|
      unless search.blank?
        search.room_searches.each do |rs|
          c.bookings.build(adults: rs.adults, item: item)
        end
        c.user = search.user
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
    id.to_s.rjust(10 , '0')
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

  #
  # Hardcoded return codes
  # :confirmed - Order confirmed
  # :canceled - Order canceled
  # false - Confirmation code does match
  #
  def receive_confirmation(confirmation)
    if confirmation.sanitized_message.match("^#{order_number}")
      confirm
      return :confirmed
    elsif confirmation.sanitized_message.match("^x#{order_number}")
      cancle
      return :canceled
    else
      return false
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
      before_validation :set_order_confirmation
      validates :billing_information_id, :email, :phone, :payment_amount, :checkout_at, :order_confirmation,
        presence: true
    end

    state :payment_processed do
      validates :payment_at,
        presence: true
    end

    before_transition :shopping => :authorizing_payment, :do => :prepare_for_checkout
    after_transition :on => :authorize_payment, :do => :submit_payment_authorization
    event :authorize_payment do
      transition :shopping => :authorizing_payment
    end

    after_transition :on => :submit, :do => :process_submission
    event :submit do
      transition :authorizing_payment => :submitted
    end

    event :pay do
      transition :submitted => :processing_payment
    end

    event :confirm_payment do
      transition :processing_payment => :payment_received
    end

    event :cancle do
      transition all => :canceled
    end

  end

  ##############################################################################################################
  ###
  ##############################################################################################################

private

  def set_order_confirmation
    self[:order_confirmation] = SecureRandom.hex.upcase[0,5] + order_number
  end

  def process_submission
    send_confirmation
    clear_unused_carts
  end

  def clear_unused_carts
    user.carts.unsubmitted.destroy_all
  end

  def confirm
    bookings.each { |b| b.confirm }
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
      SalespersonMailer.booking_confirmation(self, r).deliver
    end
    #send email to shop
  end

  def prepare_for_checkout
    set_payment_amount
    set_checkout_at
  end

  def set_checkout_at
    self.checkout_at = Time.now
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
