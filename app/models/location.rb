class Location < ActiveRecord::Base
  has_ancestry

  before_update :index_if_changed
  after_create :index

  def to_s
    name
  end

  def long
    ancestors.reverse
  end

private

  def index_if_changed
    if self.name_changed?
      SearchSuggestion.unindex_phrase(name_was)
      SearchSuggestion.index_phrase(name)
    end
  end

  def index
    SearchSuggestion.index_phrase(name)
  end
end
