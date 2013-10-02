class MemberProfile < Profile

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :send_welcome_email

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
    role?("salesperson") || admin?
  end

  def shop_owner?
    role?("shop_owner") || salesperson?
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
    #ProfileMailer.welcome_email(self).deliver
  end

  def set_shopper_role
    self.role = self.role.downcase if self.role.present?
    self.role ||= "shopper"
  end

  def valid_role?
    ROLES.include?(self.role) ? true : errors[:role] << I18n.t('simple_form.error_notification.member_profile.invalid_role')
  end

end