class PagesController < ApplicationController
  skip_authorization_check

  def index
  	@search = new_search
    @shops = browsable_shops
    @tags = Tag::HotelTag.all
  end

  def about
  end

  def contact
    @contact_form = ContactForm.new
  end

  def terms
  end

  def set_language
    store_location(params[:location])
    current_user.set_locale Language.find(params[:language_id])
    forward_to
  end
end
