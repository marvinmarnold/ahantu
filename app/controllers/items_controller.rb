class ItemsController < ApplicationController
  before_action :set_shop
  before_action :set_item, only: [:show, :edit, :update, :destroy, :photos]
  layout "leftbar", only: [:edit, :new]
  authorize_resource

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = @shop.items.build(item_params)
    respond_to do |format|
      if @item.save
        format.html { redirect_to photos_shop_item_path(@shop, @item), notice: t("item.create.notice") }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    binding.pry
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @shop, notice: t("item.update.notice") }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to @shop }
    end
  end

  def photos
    @item.photos.build
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = @shop.items.find(params[:id])
    end

    def set_shop
      @shop = current_user.shops.find(params[:shop_id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(
        :quantity,
        :max_adults,
        :published,
        :default_price,
        :price_adjustments_attributes => [:id, :price, :start_at, :end_at, :destroy_],
        :descriptions_attributes => [:id, :name, :language_id, :description, :destroy_],
        :photos_attributes => [:id, :photo, :photo_cache]
      )
    end
end
