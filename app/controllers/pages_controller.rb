class PagesController < ApplicationController
  def index
  	@search = new_search
  	@search.room_searches.build
  end

  def about
  end

  def contact
  end
end
