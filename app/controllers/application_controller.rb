class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :configure_permitted_devise_profile_parameters, if: :devise_controller?

  def current_cart
    @current_cart ||= current_user.carts.unsubmitted.find_by_id(session[current_cart_symbol])
  end
  helper_method :current_cart

  def current_user
    @current_user ||= current_profile.user

    unless @current_user.present?
      @current_user = User.create
      session[current_profile_symbol] = @current_user.profile.id
    end

    @current_user
  end
  helper_method :current_user

  def current_profile
    @current_profile ||= current_shopper_profile
    @current_profile ||= GuestProfile.find_by_id(session[current_profile_symbol])
  end

  def current_search
    @current_search ||= current_user.search
  end
  helper_method :current_search

  def new_search
    @new_search ||= current_user.new_search
  end
  helper_method :new_search

  def browsable_shops
    @browsable_shops = Shop.published
  end

  def forward_to(default = root_url)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def store_location(location = current_location)
    session[:return_to] = location
  end

  def current_location
    request.fullpath
  end
  helper_method :current_location

protected

  def current_profile_symbol
    :current_profile_id
  end

  def current_cart_symbol
    :current_cart_id
  end

  def clear_return_to
    session.delete(:return_to)
  end

  def set_locale
    I18n.locale = current_user.locale
  end

  def configure_permitted_devise_profile_parameters
    devise_parameter_sanitizer.for(:sign_up) << :language_id
    devise_parameter_sanitizer.for(:account_update) << :language_id
  end


end
