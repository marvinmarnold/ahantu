class ItemsController < ApplicationController
  before_action :set_shop
  before_action :set_item
  before_action :set_layout, only: [:edit, :new]
  load_and_authorize_resource

  # GET /items/new
  def new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    respond_to do |format|
      if @item.save
        format.html { redirect_to new_shop_item_path(@shop, @item), notice: 'Item was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @shop, notice: 'Item was successfully updated.' }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      a = params["action"]
      if a == "show" || a == "edit" || a == "update" || a == "destroy"
        @item = @shop.items.find(params[:id])
      elsif a == "new"
        @item = Item.new
      elsif a == "create"
        @item = @shop.items.build(item_params)
      end
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
        :price_adjustments_attributes => [:price, :start_at, :end_at, :destroy_],
        :descriptions_attributes => [:name, :language_id, :description, :destroy_]
      )
    end

    def set_layout
      render layout: "leftbar"
    end
end
