class Search < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  belongs_to :shop
  has_many :taggings, as: :taggable
  has_many :hotel_tags, through: :taggings, class_name: "HotelTag", source: :tag

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

  def has_hotel_tag?(tag)
    hotel_tags.include? tag
  end

  def tag_ids=(ids)
    binding.pry
    taggings.delete_all

    #add new tags
    ids.each { |tag_id| taggings.create(tag_id: tag_id)}
  end
end
