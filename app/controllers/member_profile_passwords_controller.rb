class MemberProfilePasswordsController < Devise::PasswordsController
  skip_authorization_check
  layout "centered", only: [:new]
end