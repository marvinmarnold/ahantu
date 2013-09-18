module SearchesHelper
  def searched?
    current_search.persisted?
  end
end
