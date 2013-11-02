module ShopsHelper
  def shop_address(shop)
    [].tap do |a|
      [shop.address1, shop.address2, shop.city, shop.province].each { |i| a << i unless i.blank? }
    end.join(", ")
  end
end
