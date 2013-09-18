class GuestProfile < Profile

  def guest?
  	true
  end

  def to_s
  	I18n.t("guest_profile.to_s")
  end

  def email
  	nil
  end

end
