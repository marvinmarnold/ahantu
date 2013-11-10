module ShopRequestsHelper
  def can_assign_shop_to_shop_request?(shop_request)
    shop_request.assigned? &&
    current_user == shop_request.salesperson
  end
end
