class Profile < ActiveRecord::Base
  self.abstract_class = true

  has_one :user, as: :profile, dependent: :destroy

  belongs_to :language

  before_validation :set_language

  def guest?
    false
  end

  def admin?
    false
  end

  def salesperson?
    false
  end

  def shop_owner?
    false
  end

  def shopper?
    false
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
    self.language_id ||= Language.default.id
  end

end