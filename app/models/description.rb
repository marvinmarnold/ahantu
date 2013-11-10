class Description < ActiveRecord::Base
  belongs_to :language
  belongs_to :describable, polymorphic: true

  validates  :language,# :describable_type, :describable_id, # Not yet possible with polymorphics
    presence: true

  before_update :index_if_changed_and_belongs_to_shop
  after_create :index_if_belongs_to_shop

private

  def index_if_changed_and_belongs_to_shop
    if self.name_changed? && belongs_to_shop?
      SearchSuggestion.unindex_phrase(name_was)
      SearchSuggestion.index_phrase(name)
    end
  end

  def index_if_belongs_to_shop
    SearchSuggestion.index_phrase(name) if belongs_to_shop?
  end

  def belongs_to_shop?
    # binding.pry
    # self.describable_type.constantize.find(describable_id)
    self.describable.is_a?  Shop
  end
end