class PagesController < ApplicationController
  def index
  	@search = new_search
  	@search.room_searches.build
    @shops = browsable_shops
  end

  def about
  end

  def contact
  end

  def set_language
    store_location(params[:location])
    current_user.set_locale Language.find(params[:language_id])
    forward_to
  end
end
