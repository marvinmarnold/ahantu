class Profile < ActiveRecord::Base
  self.abstract_class = true

  has_one :user, as: :profile, dependent: :destroy

  belongs_to :language

  before_validation :set_language

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

  def locale
    language.abbr
  end

  def set_locale(lang)
    self.language = lang
    self.save
  end

private

  def set_language
    self.language_id ||= Language.default.try(:id)
  end

end