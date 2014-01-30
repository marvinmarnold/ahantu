class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_authorization_check

  def all
    member_profile = MemberProfile.from_omniauth(request.env["omniauth.auth"])
    if member_profile.persisted?
      current_user.move_to_profile(member_profile)
      sign_in_and_redirect member_profile, notice: "Signed in!"
    else
      session["devise.member_profile_attributes"] = member_profile.attributes
      redirect_to new_member_profile_registration_path
    end
  end
  alias_method :facebook, :all
  alias_method :google_oauth2, :all
end