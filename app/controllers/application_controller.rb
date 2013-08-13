class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_cart
    @current_cart ||= current_user.carts.create!
  end
  helper_method :current_cart

  def current_user
    current_user = User.find_by_id(session[current_user_symbol])

    unless current_user.present?
      current_user = User.create
      session[current_user_symbol] = current_user.id
    end
    
    current_user
  end
  helper_method :current_user

private

  def current_user_symbol
    :current_user_id
  end
end
