class ShopsController < ApplicationController
  before_action :set_shop, only: [:show, :edit, :update, :destroy]
  before_action :set_layout, only: [:edit, :show]

  authorize_resource

  # GET /shops
  # GET /shops.json
  def index
    @shops = current_user.shops
  end

  # GET /shops/1
  # GET /shops/1.json
  def show
    @cart = Cart.new_from_search(current_search)
  end

  # GET /shops/new
  def new
    @shop = Shop.new
  end

  # GET /shops/1/edit
  def edit
  end

  # POST /shops
  # POST /shops.json
  def create
    @shop = Shop.new(shop_params)

    respond_to do |format|
      if @shop.save
        format.html { redirect_to @shop, notice: 'Shop was successfully created.' }
        format.json { render action: 'show', status: :created, location: @shop }
      else
        format.html { render action: 'new' }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shops/1
  # PATCH/PUT /shops/1.json
  def update
    respond_to do |format|
      if @shop.update(shop_params)
        format.html { redirect_to @shop, notice: 'Shop was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shops/1
  # DELETE /shops/1.json
  def destroy
    @shop.destroy
    respond_to do |format|
      format.html { redirect_to shops_url }
      format.json { head :no_content }
    end
  end

  def can_and_want_shop_admin?
    can_and_want?(:update, Shop)
  end
  helper_method :can_and_want_shop_admin?

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop
      @shop = Shop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shop_params
      params.require(:shop).permit(
        :city_id,
        :published,
        :logo,
        :address1,
        :address2,
        :directions,
        :website1,
        :website2,
        :website3,
        :website4,
        :website5,
        :descriptions_attributes => [:name, :language_id, :description, :destroy_]
      )
    end

    def set_layout
      if params["action"] == "edit" || can_and_want_shop_admin?
        render layout: "leftbar"
      end
    end
end
