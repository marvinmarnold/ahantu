class MemberProfile < Profile

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :owned_shop_requests, foreign_key: :shop_owner_profile_id, class_name: "ShopRequest"
  has_many :assigned_shop_requests, foreign_key: :salesperson_profile_id, class_name: "ShopRequest"

  attr_accessor :suggested_role

  after_create :send_welcome_email
  after_create :create_shop_request_if_shop_owner

  validates :role, presence: true
  validate :valid_role?

  before_validation :set_shopper_role

  scope   :admins, lambda { where(role: "admin") }
  scope   :salespersons, lambda { where(role: "salesperson") }
  scope   :shoppers, lambda { where(role: "shopper") }
  scope   :shop_owners, lambda { where(role: "shop_owner") }

  ROLES = %w[admin salesperson shop_owner shopper]



  def to_s
    self.email
  end

  def shop_requests
    if shop_owner?
      owned_shop_requests
    elsif salesperson?
      assigned_shop_requests
    else
      ShopRequest.none
    end
  end

def self.from_omniauth(auth)
  conditions = auth.slice(:provider, :uid)
  throw :undefined_prodiver_or_uid unless conditions.present?
  where(conditions).first_or_create do |member_profile|
    member_profile.provider = auth.provider
    member_profile.uid = auth.uid
    member_profile.email = auth.info.email
    member_profile.role = "shopper"
  end
end

def self.new_with_session(params, session)
  if session["devise.member_profile_attributes"]
    new(session["devise.member_profile_attributes"]) do |member_profile|
      member_profile.attributes = params
      member_profile.valid?
    end
  else
    super
  end
end

def password_required?
  super && provider.blank?
end

def update_with_password(params, *options)
  if encrypted_password.blank?
    update_attributes(params, *options)
  else
    super
  end
end

private

  def send_welcome_email
    WelcomeEmailWorker.perform_async(self.id)
  end

  def set_shopper_role
    self.role = self.role.downcase if self.role.present?
    self.role ||= "shopper"
  end

  def valid_role?
    ROLES.include?(self.role) ? true : errors[:role] << I18n.t('simple_form.error_notification.member_profile.invalid_role')
  end

  def create_shop_request_if_shop_owner
    shop_requests.create(
      shop_name: "First shop from account creation",
      location: Location.first,
      request: "Automatic request from account creation"
    ) if shop_owner?
  end
end