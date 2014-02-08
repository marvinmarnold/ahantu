class ContactForm < ActiveRecord::Base
  belongs_to :user
  validates :from, :to, :subject, :body, :user_id,
    presence: true

  before_validation :set_to

  private

  def set_to
    self.to ||= I18n.t("general.brand")
  end
end