class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]
  layout "rightbar", only: [:edit]

  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.all
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = current_user.carts.build(cart_params)

    respond_to do |format|
      if @cart.save
        @cart.fill_bookings(current_search)
        session[current_cart_symbol] = @cart.id
        format.html { redirect_to edit_cart_path(@cart)}
      else
        format.html { render action: 'new' }

      end
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params) && @cart.submit
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to carts_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = current_user.carts.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params.require(:cart).permit(:email, :phone, :billing_information_id, :bookings_attributes => [:item_id, :adults, :responsible_name, :id])
    end
end
