class ShopRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :salesperson, class_name: "User"

  validates :shop_name, :location_id,
    presence: true

  ##############################################################################################################
  ### state machine
  ##############################################################################################################

  state_machine :state, :initial => :open do

    # state :authorizing_payment do
    #   validates :billing_information_id, :email, :phone, :payment_amount, :checkout_at, :order_confirmation,
    #     presence: true
    # end

    # before_transition :on => :authorize_payment, :do => :prepare_for_checkout
    # event :authorize_payment do
    #   transition :shopping => :authorizing_payment, :if => lambda {|cart| cart.send :submit_payment_authorization }
    # end

  end

  ##############################################################################################################
  ###
  ##############################################################################################################
end
