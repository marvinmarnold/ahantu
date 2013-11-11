class SearchesController < ApplicationController
  before_action :set_search, only: [:show, :edit, :update, :destroy, :finalize]
  layout "leftbar", only: [:show, :new]

  authorize_resource

  # GET /searches
  # GET /searches.json
  def index
    redirect_to new_search_path
  end

  # GET /searches/1
  # GET /searches/1.json
  def show
    return redirect_to @serch.shop if @search.shop.present?
    @results = @search.results.paginate(:page => params[:page], :per_page => per_page)
  end

  # GET /searches/new
  def new
    new_search
  end

  # GET /searches/1/edit
  def edit
    redirect_to @search
  end

  # POST /searches
  # POST /searches.json
  def create
    @search = current_user.searches.build(search_params)

    respond_to do |format|
      if @search.save
        format.html { redirect_to @search }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /searches/1
  # PATCH/PUT /searches/1.json
  def update
    respond_to do |format|
      if @search.update(search_params)
        format.html { redirect_to @search }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /searches/1
  # DELETE /searches/1.json
  def destroy
    @search.destroy
    respond_to do |format|
      format.html { redirect_to searches_url }
    end
  end

  def finalize

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search
      @search = current_user.searches.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params.require(:search).permit(
        :keyword,
        :checkin_at,
        :checkout_at,
        :room_searches_attributes => [:adults, :_destroy],
        :tag_ids => []
      )
    end
end
