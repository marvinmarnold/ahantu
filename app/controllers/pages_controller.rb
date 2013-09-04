class PagesController < ApplicationController
  def index
  	@search = new_search
  	@search.room_searches.build
  	binding.pry
  end

  def about
  end

  def contact
  end
end
