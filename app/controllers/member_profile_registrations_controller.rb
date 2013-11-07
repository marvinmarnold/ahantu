class MemberProfileRegistrationsController < DeviseRegistrationsController
  layout "centered", only: [:new, :create]

  def create
    ensure_can_register_as_role
    build_resource(sign_up_params)
    # binding.pry
    if resource.save
      current_user.move_to_profile(resource)
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  def ensure_can_register_as_role
    suggested_role = params[:member_profile][:suggested_role]
    if suggested_role.present? && can?("register_as_#{suggested_role}".to_sym, MemberProfile)
      params[:member_profile][:role] ||= suggested_role
    end
  end
end