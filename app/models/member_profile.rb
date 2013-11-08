class MemberProfile < Profile

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :shop_requests, foreign_key: :shop_owner_profile_id, class_name: "ShopRequest"
  has_many :assigned_shop_request, foreign_key: :salesperson_profile_id, class_name: "ShopRequest"

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

  def guest?
    false
  end

  def admin?
    role?("admin")
  end

  def salesperson?
    role?("salesperson")
  end

  def shop_owner?
    role?("shop_owner")
  end

  def shopper?
    role?("shopper")
  end

  def role?(role)
    self.role.downcase == role
  end

  def to_s
    self.email
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
      request: "Automatic request from account creation"
    ) if shop_owner?
  end
end