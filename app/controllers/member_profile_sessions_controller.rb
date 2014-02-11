class MemberProfileSessionsController < Devise::SessionsController
  skip_authorization_check
  layout "centered", only: [:new, :create]

end