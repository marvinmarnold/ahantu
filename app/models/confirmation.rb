  class Confirmation < ActiveRecord::Base
  belongs_to :booking
  belongs_to :sender, polymorphic: true
  belongs_to :recipient, polymorphic: true

  def self.sanitize_text(text)
    text.downcase.delete(' ')
  end

  def sanitized_message
    Confirmation.sanitize_text(self.message)
  end
end
