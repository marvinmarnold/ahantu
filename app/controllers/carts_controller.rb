class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]
  layout "rightbar", only: [:edit]
  authorize_resource

  # GET /carts
  # GET /carts.json
  def index
    @carts = current_user.browsable_carts
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = current_user.carts.build(cart_params)
    @cart.search = current_search
    @cart.fill_bookings

    respond_to do |format|
      if @cart.save
        session[current_cart_symbol] = @cart.id
        format.html { redirect_to edit_cart_path(@cart)}
      else
        format.html { render action: 'new' }
      end
    end
  end

  # GET /carts/1/edit
  def edit
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params) && @cart.complete_checkout && @cart.update_attributes(search: current_search)
        format.html { redirect_to @cart, notice: I18n.t("cart.update.notice") }
        format.js
      else
        format.html { render action: 'edit' }
        format.js
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    redirect_to new_search_path
  end

  def one_click_checkout
    @cart = current_user.carts.new_with_bookings(current_search, Item.find(params[:item_id].to_i))
    @cart.fill_bookings

    respond_to do |format|
      if @cart.save
        session[current_cart_symbol] = @cart.id
        format.html { redirect_to edit_cart_path(@cart)}
      else
        format.html { render action: 'edit' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = current_user.carts.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params.require(:cart).permit(
        :email,
        :phone,
        :billing_information_id,
        :terms_accepted,
        :bookings_attributes => [:item_id, :adults, :responsible_name, :id]
      )
    end

end
