module ShopsHelper
  def can_and_want_shop_admin?
    can_and_want?(:update, Shop)
  end
end
