class PagesController < ApplicationController
  def index
  	@search = current_search
  end

  def about
  end

  def contact
  end
end
