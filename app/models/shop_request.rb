class ShopRequest < ActiveRecord::Base
  belongs_to :shop_owner_profile, class_name: "MemberProfile"
  belongs_to :salesperson_profile, class_name: "MemberProfile"
  belongs_to :location
  belongs_to :shop

  scope   :incomplete, lambda { where.not(state: "completed") }

  validates :shop_name, :location_id, :shop_owner_profile_id,
    presence: true

  def assign_to(salesperson)
    self.salesperson_profile = salesperson.profile
    self.save
    assign
  end

  def salesperson
    salesperson_profile.try(:user)
  end

  def shop_owner
    shop_owner_profile.user
  end

  def to_s
    shop_owner
  end

  ##############################################################################################################
  ### state machine
  ##############################################################################################################

  state_machine :state, :initial => :open do

    state :assigned do
      validates :salesperson_profile_id,
        presence: true
    end

    state :completed do
      validates :shop_id,
        presence: true
    end

    event :assign do
      transition :open => :assigned
    end

    event :complete do
      transition :assigned => :completed
    end

  end

  ##############################################################################################################
  ###
  ##############################################################################################################
end
