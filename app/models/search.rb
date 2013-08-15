class Search < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  belongs_to :shop

  def results(filtered_shops = Shop.published)
    filtered_shops = filtered_by_keyword(filtered_shops)
    filtered_shops.uniq
  end


  def filtered_by_keyword(filtered_shops = Shop.published)
    k = "%#{self.keyword}%"
    if self.keyword.present?
      filtered_shops = filtered_shops.joins(:city => :province).joins(:descriptions).
        where("descriptions.name ilike :k or description ilike :k or cities.name ilike :k or provinces.name ilike :k",
        { k: k })
    end

    filtered_shops
  end
end
