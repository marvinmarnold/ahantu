module MemberProfileRegistrationsHelper
  def suggested_role
    params[suggested_role_symbol]
  end
end
