class SearchSuggestionsController < ApplicationController
  skip_authorization_check

  def index
    render json: SearchSuggestion.terms_for(params[:term])
  end
end
