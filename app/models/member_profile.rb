class MemberProfile < Profile

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :send_welcome_email

  validates :role, presence: true

  before_validation :set_shopper_role

  scope   :admins, lambda { where(role: "admin") }
  scope   :salespersons, lambda { where(role: "salesperson") }
  scope   :shoppers, lambda { where(role: "shopper") }

  def guest?
    role?("guest")
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
    #ProfileMailer.welcome_email(self).deliver
  end

  def set_shopper_role
    self.role ||= "shopper"
  end

end