class EmailAddress < Contact
  def self.address(username, domain)
    "#{username}@#{domain}"
  end
end