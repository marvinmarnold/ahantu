module ShopsHelper
  def shop_address(shop)
    [].tap do |a|
      [shop.address1, shop.address2, shop.locations].each { |i| a << i unless i.blank? }
    end.join(", ")
  end

  def shop_published_warning(shop)
    if shop.published?
      status_class = "badge-success"
      label = I18n.t("shop.index.list.published_warning.published")
    else
      status_class = "badge-important"
      label = I18n.t("shop.index.list.published_warning.unpublished")
    end

    content_tag "span", class: "badge #{status_class}" do label end
  end
end
